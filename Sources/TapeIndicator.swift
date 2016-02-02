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
    private let cells: [TapeIndicatorCell]
    
    init(style: TapeIndicatorStyle) {
        self.style = style
        cells = (0..<3).map {_ in 
            let cellModel = TapeIndicatorCellModel(lowerValue: 0, upperValue: 1)
            return TapeIndicatorCell(model: cellModel, style: style.cellStyle)
        }
        super.init()
        addBackgroundNode()
        addInitialCellNodes()
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
        
        let models: [TapeIndicatorCellModel] = (0..<Int(cells.count)).map { index in
            let valueRange = style.optimalCellValueRange
            let lowerValue = index * (valueRange + 1)
            let upperValue = lowerValue + valueRange
            return TapeIndicatorCellModel(lowerValue: lowerValue, upperValue: upperValue)
        }
        
        zip(models, cells).forEach { (model, cell) in
            cell.model = model
            addChild(cell)
        }
        value = 0
    }
    
    private func optimalCellModelForLowerValue(lowerValue: Int) -> TapeIndicatorCellModel {
        
        switch style.range {
        case .Continuous:
            return TapeIndicatorCellModel(
                lowerValue: lowerValue,
                upperValue: lowerValue + style.optimalCellValueRange)
        case .Loop(let range):
            return TapeIndicatorCellModel(
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
