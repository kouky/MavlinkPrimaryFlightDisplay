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
    let cellContainer: TapeCellContainer
    var value: Double = 0 {
        didSet {
            cellContainer.runAction(cellContainer.actionForValue(value))
        }
    }
    
    init(style: TapeIndicatorStyle) {
        guard let model = try? TapeCellModel(lowerValue: 0, upperValue: style.optimalCellValueRange) else {
            fatalError("Could not create seed tape cell model")
        }
        self.style = style
        cellContainer = TapeCellContainer(seedModel: model, cellStyle: style.cellStyle)
        
        super.init()
        addBackgroundNode()
        addChild(cellContainer)
    }
    
    func recycleCells() {
        cellContainer.recycleCells()
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
}
