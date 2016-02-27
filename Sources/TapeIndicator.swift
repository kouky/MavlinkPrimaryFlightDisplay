//
//  TapeIndicator.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 18/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit


class TapeIndicator: SKNode {
    
    let style: TapeStyle
    let pointer: TapePointer
    let cellContainer: TapeCellContainer
    let cropNode = SKCropNode()
    
    var value: Double = 0 {
        didSet {
            cellContainer.runAction(cellContainer.actionForValue(value))
            pointer.value = Int(value)
        }
    }
    
    init(style: TapeStyle) {
        self.style = style
        let seedModel = style.seedModel
        do {
            cellContainer = try TapeCellContainer(seedModel: seedModel, style: style)
        } catch  {
            fatalError("Seed model lower value must be zero")
        }
        pointer = TapePointer(initialValue: style.seedModel.lowerValue, style: style)
        super.init()

        let backgroundShape = SKShapeNode(rectOfSize: style.size, cornerRadius: 2)
        backgroundShape.fillColor = style.backgroundColor
        backgroundShape.strokeColor = SKColor.clearColor()

        backgroundShape.zPosition = 0
        cellContainer.zPosition = 1
        pointer.zPosition = 2
        
        cropNode.addChild(backgroundShape)
        cropNode.addChild(cellContainer)
        cropNode.addChild(pointer)
        cropNode.maskNode = SKSpriteNode(color: SKColor.blackColor(), size: style.size)
        addChild(cropNode)
    }
    
    func recycleCells() {
        cellContainer.recycleCells()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
