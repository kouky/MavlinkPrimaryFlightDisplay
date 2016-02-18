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
        return SKAction.moveTo(positionForValue(value), duration: 3)
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
    
    private func positionForValue(value: Double) -> CGPoint {
        // TODO: Account for initial value
        let valuePosition =  -value * Double(style.markerStyle.pointsPerValue)
        switch style.markerStyle.justification {
        case .Top, .Bottom:
            return CGPoint(x: CGFloat(valuePosition), y: position.y)
        case .Left, .Right:
            return CGPoint(x: position.x, y: CGFloat(valuePosition))
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
}
