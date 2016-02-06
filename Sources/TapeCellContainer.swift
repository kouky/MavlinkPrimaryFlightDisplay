//
//  TapeCellContainer.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 6/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class TapeCellContainer: SKNode {
    
    let cells: [TapeCell]
    let cellStyle: TapeCellStyle
    
    init(seedModel: TapeCellModel, cellStyle: TapeCellStyle) {
        
        do {
            let centerCell = TapeCell(model: seedModel, style: cellStyle)
            let previousCell = TapeCell(model: try seedModel.previous(), style: cellStyle)
            let nextCell = TapeCell(model: try seedModel.next(), style: cellStyle)
            cells = [previousCell, centerCell, nextCell]
        } catch {
            fatalError("Could not create tape cells")
        }
        self.cellStyle = cellStyle
        
        super.init()
        let initialValue = Double(seedModel.lowerValue)
        cells.forEach { cell in
            addChild(cell)
            cell.position = cell.positionForValue(initialValue)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func recycleCells() {
        print(valueForPosition())
    }
    
    func positionForValue(value: Double) -> CGPoint {
        let valuePosition =  -value * Double(cellStyle.pointsPerValue)
        switch cellStyle.justification {
        case .Top, .Bottom:
            return CGPoint(x: CGFloat(valuePosition), y: position.y)
        case .Left, .Right:
            return CGPoint(x: position.x, y: CGFloat(valuePosition))
        }
    }
    
    func actionForValue(value: Double) -> SKAction {
        return SKAction.moveTo(positionForValue(value), duration: 3)
    }
    
    private func valueForPosition() -> Double {
        switch cellStyle.justification {
        case .Top, .Bottom:
            return -Double(position.x) / Double(cellStyle.pointsPerValue)
        case .Left, .Right:
            return -Double(position.y) / Double(cellStyle.pointsPerValue)
        }
    }
}
