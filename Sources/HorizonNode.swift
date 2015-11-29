//
//  HorizonNode.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 21/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class HorizonNode: SKNode {

    private let skyNode = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 100, height: 100))
    private let groundNode = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: 100, height: 100))
    
    init(size: CGSize) {
        super.init()
        skyNode.size = CGSize(width: size.width/2, height: size.height/2)
        groundNode.size = CGSize(width: size.width/2, height: size.height/2)
        skyNode.position = CGPoint(x: 0, y: size.height/4)
        groundNode.position = CGPoint(x: 0, y: -size.height/4)
        addChild(skyNode)
        addChild(groundNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
