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
    private let style: TapeStyle
    private let initialValue: Double
    
    init(seedModel: TapeCellModelType, style: TapeStyle) {
        
        do {
            let centerCell = TapeCell(model: seedModel, style: style)
            let previousCell = TapeCell(model: try seedModel.previous(), style: style)
            let nextCell = TapeCell(model: try seedModel.next(), style: style)
            cellTriad = TapeCellTriad(cell1: previousCell, cell2: centerCell, cell3: nextCell)
        } catch {
            fatalError("Could not create next / previous tape cell")
        }
        self.style = style
        initialValue = Double(seedModel.lowerValue)
        
        super.init()
        cellTriad.forEach { cell in
            addChild(cell)
            cell.position = cell.positionForValue(initialValue)
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
        do {
            switch status {
            case ((true, let cell1),  (false, _),  (false, let cell3)):
                cell3.model = try cell1.model.previous()
                cell3.position = cell3.positionForValue(initialValue)
                break
            case ((false, let cell1),  (false, _),  (true, let cell3)):
                cell1.model = try cell3.model.next()
                cell1.position = cell1.positionForValue(initialValue)
                break
            case ((false, _),  (false, _),  (false, _)):
                //TODO: Handle case
                break
            default:
                break
            }
        } catch {
            fatalError("Cannot create next / previous tape cell model")
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
        let valuePosition =  -value * Double(style.markerStyle.pointsPerValue)
        switch style.markerStyle.justification {
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
        switch style.markerStyle.justification {
        case .Top, .Bottom:
            return -Double(position.x) / Double(style.markerStyle.pointsPerValue)
        case .Left, .Right:
            return -Double(position.y) / Double(style.markerStyle.pointsPerValue)
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
}
