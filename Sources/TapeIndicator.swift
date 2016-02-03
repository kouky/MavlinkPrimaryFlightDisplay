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
            let cellModel = TapeCellModel(lowerValue: 0, upperValue: 1)
            return TapeCell(model: cellModel, style: style.cellStyle)
        }
        super.init()
        addBackgroundNode()
        addInitialCellNodes()
    }
    
    func recycleCells() {
        // TODO: Implement
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
        
        let models: [TapeCellModel] = (0..<Int(cells.count)).map { index in
            let valueRange = style.optimalCellValueRange
            let lowerValue = index * (valueRange + 1)
            let upperValue = lowerValue + valueRange
            return TapeCellModel(lowerValue: lowerValue, upperValue: upperValue)
        }
        
        zip(models, cells).forEach { (model, cell) in
            cell.model = model
            addChild(cell)
            cell.position = cell.positionForValue(value)
        }
    }
    
    private func optimalCellModelForLowerValue(lowerValue: Int) -> TapeCellModel {
        
        switch style.range {
        case .Continuous:
            return TapeCellModel(
                lowerValue: lowerValue,
                upperValue: lowerValue + style.optimalCellValueRange)
        case .Loop(let range):
            return TapeCellModel(
                lowerValue: lowerValue, upperValue:
                (lowerValue + style.optimalCellValueRange) % range.endIndex)
        }
    }
    
    private func updateCellPositions() {
        cells.forEach { [weak self] cell in
            guard let value = self?.value else { return  }
            cell.runAction(cell.actionForValue(value))
        }
    }
}
