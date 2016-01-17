//
//  BankIndicator.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 14/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit
import Darwin

class BankIndicator: SKNode {
    
    override init() {
        super.init()
        addChild(BankArc())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BankIndicator: AttitudeSettable {
    
    func setAttitude(attitude: AttitudeType) {
        runAction(attitude.rollAction())
    }
}

private class BankArc: SKNode {
    
    private let radianClipping = M_PI/3
 
    override init() {
        super.init()

        let arc = SKShapeNode(circleOfRadius: CGFloat(Constants.Size.BankIndicator.radius))
        let cropNode = SKCropNode()
        let maskNodeEdgeSize = Constants.Size.BankIndicator.radius * 2 + Constants.Size.BankIndicator.lineWidth
        let maskNode = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: maskNodeEdgeSize, height: maskNodeEdgeSize))
        
        arc.lineWidth = CGFloat(Constants.Size.BankIndicator.lineWidth)
        cropNode.addChild(arc)
        cropNode.maskNode = maskNode
        let y = CGFloat(cos(radianClipping)) * CGFloat(Constants.Size.BankIndicator.radius)
        cropNode.maskNode?.position = CGPoint(x: 0, y: CGFloat(Constants.Size.BankIndicator.radius) + y)
        addChild(cropNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
