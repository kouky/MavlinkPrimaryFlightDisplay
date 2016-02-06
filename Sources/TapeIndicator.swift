//
//  TapeIndicator.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 18/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit


class TapeIndicator: SKNode {
    
    let style: TapeIndicatorStyle
    var value: Double = 0 {
        didSet {
            updateCellPositions()
        }
    }
    private let cells: [TapeCell]
    
    init(style: TapeIndicatorStyle) {
        self.style = style
        
        do {
            let model = try TapeCellModel(lowerValue: 0, upperValue: 1)
            cells = (0..<3).map { _ in
                TapeCell(model: model, style: style.cellStyle)
            }
        } catch {
            fatalError("Cannot build tape cell model")
        }
        
        super.init()
        addBackgroundNode()
        addCellNodes()
    }
    
    func recycleCells() {
        let status = cells.statusForPosition()
        let x = status.map { ($0.valueForPosition, $0.containsValueForPosition) }
        print(x)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addBackgroundNode() {
        let backgroundShape = SKShapeNode(rectOfSize: style.size, cornerRadius: 2)
        backgroundShape.fillColor = style.backgroundColor
        backgroundShape.strokeColor = SKColor.clearColor()
        addChild(backgroundShape)
    }
    
    private func addCellNodes() {
        
        // TODO: Account for tape range
        let models: [TapeCellModel]
        do {
            models = try (0..<Int(cells.count)).reduce([]) { (acc: [TapeCellModel], _) in
                
                guard let lastModel = acc.last else {
                    return [try TapeCellModel(lowerValue: 0, upperValue: style.optimalCellValueRange)]
                }
                return acc + [try lastModel.next()]
            }
        } catch {
            fatalError("Cannot build tape cell model")
        }
        
        zip(models, cells).forEach { (model, cell) in
            cell.model = model
            addChild(cell)
            cell.position = cell.positionForValue(value)
        }
    }
    
    private func updateCellPositions() {
        cells.forEach { [weak self] cell in
            guard let value = self?.value else { return  }
            cell.runAction(cell.actionForValue(value))
        }
    }
}
