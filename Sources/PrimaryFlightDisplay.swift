//
//  PrimaryFlightDisplayScene.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 21/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import SpriteKit

public class PrimaryFlightDisplayView: SKView {
    
    // MARK: Initializers
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let scene = PrimaryFlightDisplayScene(size: bounds.size)
        scene.scaleMode = .AspectFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        presentScene(scene)
        
        // Apply additional optimizations to improve rendering performance
        ignoresSiblingOrder = true
        
        // Diagnostics
        showsFPS = true
        showsNodeCount = true
    }
    
    // MARK: Public Methods
    
    public func updateAttitude(roll: Float) {
        if let scene = scene as? PrimaryFlightDisplayScene {
            scene.updateRoll(roll)
        }
    }
}

private class PrimaryFlightDisplayScene: SKScene {
    
    let horizonNode: HorizonNode

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
    
    func updateRoll(roll: Float) {
        horizonNode.runAction(SKAction.rotateToAngle(-CGFloat(roll), duration: 0.1, shortestUnitArc: true))
    }
}
