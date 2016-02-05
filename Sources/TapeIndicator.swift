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
        cells = (0..<3).map {_ in 
            guard let cellModel = try? TapeCellModel(lowerValue: 0, upperValue: 1) else {
                fatalError("Canno build tape cell model")
            }
            return TapeCell(model: cellModel, style: style.cellStyle)
        }
        super.init()
        addBackgroundNode()
        addInitialCellNodes()
    }
    
    func recycleCells() {
        let status = cells.statusForPosition()
        let x = status.map { ($0.value, $0.containsValue) }
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
    
    private func addInitialCellNodes() {
        
        // TODO: Account for tape range
        let models: [TapeCellModel] = (0..<Int(cells.count)).map { index in
            let valueRange = style.optimalCellValueRange
            let lowerValue = index * (valueRange + 1)
            let upperValue = lowerValue + valueRange

            guard let model = try? TapeCellModel(lowerValue: lowerValue, upperValue: upperValue) else {
                fatalError("Canno build tape cell model")
            }
            return model
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
