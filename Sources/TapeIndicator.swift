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
    
    init(style: TapeIndicatorStyle) {
        self.style = style
        super.init()
        configureNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNodes() {
        let backgroundShape = SKShapeNode(rectOfSize: style.size, cornerRadius: 2)
        backgroundShape.fillColor = style.backgroundColor
        backgroundShape.strokeColor = SKColor.clearColor()
        addChild(backgroundShape)
        addChild(TapeIndicatorCell(
            model: optimalCellModelForLowerValue(0),
            style: style.cellStyle))
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
}
