//
//  Horizon.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 21/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class Horizon: SKNode, SceneType {
    
    let sceneSize: CGSize

    private let skyNode = SKSpriteNode(color: Constants.Color.Horizon.sky, size: CGSize(width: 100, height: 100))
    private let groundNode = SKSpriteNode(color: Constants.Color.Horizon.ground, size: CGSize(width: 100, height: 100))
    private let zeroPitchLine: SKShapeNode
    
    init(sceneSize: CGSize) {
        self.sceneSize = sceneSize
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

extension Horizon: AttitudeSettable {
    
    func setAttitude(attitude: AttitudeType) {
        let sequence = SKAction.sequence([attitude.pitchAction(), attitude.rollAction()])
        runAction(sequence)
    }
}

