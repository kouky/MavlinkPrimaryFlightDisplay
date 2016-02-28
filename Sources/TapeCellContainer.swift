//
//  TapeCellContainer.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 6/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class TapeCellContainer: SKNode {
    
    private let cellTriad: TapeCellTriad
    private let style: TapeIndicatorStyleType
    
    enum Error: ErrorType {
        case SeedModelLowerValueMustBeZero
    }
    
    init(seedModel: TapeCellModelType, style: TapeIndicatorStyleType) throws {
        let centerCell = TapeCell(model: seedModel, style: style)
        let previousCell = TapeCell(model: seedModel.previous(), style: style)
        let nextCell = TapeCell(model: seedModel.next(), style: style)
        cellTriad = TapeCellTriad(cell1: previousCell, cell2: centerCell, cell3: nextCell)
        self.style = style
        super.init()
        
        guard seedModel.lowerValue == 0 else {
            throw Error.SeedModelLowerValueMustBeZero
        }

        cellTriad.forEach { cell in
            addChild(cell)
            cell.position = cell.positionForZeroValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func actionForValue(value: Double) -> SKAction {
        switch style.type {
        case .Continuous:
            return SKAction.moveTo(positionForContinuousValue(value), duration: 0.05)
        case .Compass:
            return SKAction.moveTo(positionForCompassValue(value), duration: 0.2)
        }
    }
    
    func recycleCells() {
        let status = cellTriad.statusForValue(valueForPosition())
        
        switch status {
        case ((true, let cell1),  (false, _),  (false, let cell3)):
            recycleCell(cell3, model: cell1.model.previous())
            break
        case ((false, let cell1),  (false, _),  (true, let cell3)):
            recycleCell(cell1, model: cell3.model.next())
            break
        case ((false, let cell1),  (false, let cell2),  (false, let cell3)):
            let model = modelForValue(valueForPosition(), fromModel: cell2.model)
            recycleCell(cell1, model: model.previous())
            recycleCell(cell2, model: model)
            recycleCell(cell3, model: model.next())
            break
        default:
            break
        }
    }
    
    private func valueForPosition() -> Double {
        switch style.type {
        case .Continuous:
            return continuousValueForPosition()
        case .Compass:
            return continuousValueForPosition().compassValue
        }
    }
    
    private func positionForContinuousValue(value: Double) -> CGPoint {
        // TODO: Account for initial value
        let valuePosition =  -value * Double(style.pointsPerUnitValue)
        switch style.markerJustification {
        case .Top, .Bottom:
            return CGPoint(x: CGFloat(valuePosition), y: position.y)
        case .Left, .Right:
            return CGPoint(x: position.x, y: CGFloat(valuePosition))
        }
    }
    
    private func positionForCompassValue(compassValue: Double) -> CGPoint {
        let left = leftwardValueDeltaFromCompassValue(continuousValueForPosition().compassValue, toCompassValue: compassValue)
        let right = rightwardValueDeltaFromCompassValue(continuousValueForPosition().compassValue, toCompassValue: compassValue)
        
        if abs(left) < abs(right) {
            let newContinuousValue = continuousValueForPosition() + left
            return positionForContinuousValue(newContinuousValue)
        } else {
            let newContinuousValue = continuousValueForPosition() + right
            return positionForContinuousValue(newContinuousValue)
        }
    }
    
    private func continuousValueForPosition() -> Double {
        switch style.markerJustification {
        case .Top, .Bottom:
            return -Double(position.x) / Double(style.pointsPerUnitValue)
        case .Left, .Right:
            return -Double(position.y) / Double(style.pointsPerUnitValue)
        }
    }
    
    private func rightwardValueDeltaFromCompassValue(fromCompassValue: Double, toCompassValue: Double) -> Double {
        if fromCompassValue < toCompassValue {
            return toCompassValue - fromCompassValue
        }
        else {
            return toCompassValue - fromCompassValue + 360
        }
    }
    
    private func leftwardValueDeltaFromCompassValue(fromCompassValue: Double, toCompassValue: Double) -> Double {
        if fromCompassValue < toCompassValue {
            return toCompassValue - fromCompassValue - 360
        }
        else {
            return toCompassValue - fromCompassValue
        }
    }
    
    private func modelForValue(value: Double, fromModel model: TapeCellModelType) -> TapeCellModelType {
        if model.containsValue(value) {
            return model
        } else if value < model.midValue {
            return modelForValue(value, fromModel: model.previous())
        } else {
            return modelForValue(value, fromModel: model.next())
        }
    }
    
    private func recycleCell(cell: TapeCell, model: TapeCellModelType) {
        cell.model = model
        cell.position = cell.positionForZeroValue
    }
}
