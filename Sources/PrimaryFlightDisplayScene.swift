//
//  PrimaryFlightDisplayScene.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 21/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class PrimaryFlightDisplayScene: SKScene {
    
    private let horizonNode: HorizonNode

    override init(size: CGSize) {
        horizonNode = HorizonNode(size: size)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToView(view: SKView) {
        horizonNode.position = CGPoint(x:0, y:0);
        addChild(horizonNode)
    }
}
