//
//  TapeIndicator.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 18/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeIndicatorStyle {
    enum Orientation {
        case Vertical
        case Horizontal
    }
    
    enum Justification {
        case Top
        case Bottom
        case Left
        case Right
    }
    
    let orientation: Orientation
    let justification: Justification
}

protocol TapeIndicatorType {
    var size: CGSize { get }
    var backgroundColor: SKColor { get }
    var style: TapeIndicatorStyle { get }
}

class TapeIndicator: SKNode, TapeIndicatorType {
    
    let size: CGSize
    var backgroundColor: SKColor
    let style: TapeIndicatorStyle
    
    init(size: CGSize, style: TapeIndicatorStyle, backgroundColor: SKColor) {
        self.size = size
        self.style = style
        self.backgroundColor = backgroundColor
        super.init()
        configureNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNodes() {
        let backgroundShape = SKShapeNode(rectOfSize: size, cornerRadius: 5)
        backgroundShape.fillColor = backgroundColor
        backgroundShape.strokeColor = SKColor.clearColor()
        addChild(backgroundShape)
    }
}
