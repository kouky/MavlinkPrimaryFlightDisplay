//
//  PrimaryFlightDisplayScene.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 21/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import SpriteKit
import Darwin

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
        
    public func updateAttitude(roll: Float, pitch: Float) {
        if let scene = scene as? PrimaryFlightDisplayScene {
            scene.updateAttitude(pitch, roll: roll)
        }
    }
}

private class PrimaryFlightDisplayScene: SKScene {
    
    let artificalHorizon: ArtificialHorizon
    let attitudeReferenceIndex = AttitudeReferenceIndex()

    override init(size: CGSize) {
        artificalHorizon = ArtificialHorizon(size: size)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToView(view: SKView) {
        artificalHorizon.position = CGPointZero
        addChild(artificalHorizon)
        attitudeReferenceIndex.position = CGPointZero
        addChild(attitudeReferenceIndex)
    }
    
    func updateAttitude(pitch: Float, roll: Float) {
        let x = CGFloat(pitch) * -300
        let rollaction = SKAction.rotateToAngle(CGFloat(roll), duration: 0.05, shortestUnitArc: true)
        let pitchAction = SKAction.moveToY(x, duration: 0.05)
        let sequence = SKAction.sequence([pitchAction,rollaction])
        artificalHorizon.runAction(sequence)
    }
}
