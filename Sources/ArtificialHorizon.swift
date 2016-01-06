//
//  ArtificialHorizon.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 21/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class ArtificialHorizon: SKNode {

    private let skyNode = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 100, height: 100))
    private let groundNode = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: 100, height: 100))
    private let zeroPitchLine: SKShapeNode
    
    init(sceneSize: CGSize) {
        zeroPitchLine = SKShapeNode(rectOfSize: CGSize(width: 2 * sceneSize.width, height: 1))
        super.init()
        
        skyNode.size = CGSize(width: sceneSize.width/2, height: sceneSize.height/2)
        groundNode.size = CGSize(width: sceneSize.width/2, height: sceneSize.height/2)
        skyNode.position = CGPoint(x: 0, y: sceneSize.height/4)
        groundNode.position = CGPoint(x: 0, y: -sceneSize.height/4)
        zeroPitchLine.strokeColor = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        zeroPitchLine.position = CGPoint.zero
        
        addChild(skyNode)
        addChild(groundNode)
        addChild(zeroPitchLine)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArtificialHorizon: AttitudeAdjustable {
    
    func setAttitude(pitch pitch: Float, roll: Float) {
        let x = CGFloat(pitch) * -300
        let rollaction = SKAction.rotateToAngle(CGFloat(roll), duration: 0.05, shortestUnitArc: true)
        let pitchAction = SKAction.moveToY(x, duration: 0.05)
        let sequence = SKAction.sequence([pitchAction,rollaction])
        runAction(sequence)
    }
}

