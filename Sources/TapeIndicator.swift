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
    private var cells = [TapeIndicatorCell]()
    
    init(style: TapeIndicatorStyle) {
        self.style = style
        super.init()
        addNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addNodes() {
        let backgroundShape = SKShapeNode(rectOfSize: style.size, cornerRadius: 2)
        backgroundShape.fillColor = style.backgroundColor
        backgroundShape.strokeColor = SKColor.clearColor()
        addChild(backgroundShape)
        let cell = TapeIndicatorCell(
            model: optimalCellModelForLowerValue(0),
            style: style.cellStyle)
        addChild(cell)
        cells.append(cell)
        self.value = 0
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
