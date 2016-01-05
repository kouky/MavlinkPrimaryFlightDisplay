//
//  Gyroscope.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 5/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class Gyroscope: SKNode {
    
    private let horizon: ArtificialHorizon
    private let pitchLadder: PitchLadder
    
    init(sceneSize: CGSize) {
        horizon = ArtificialHorizon(sceneSize: sceneSize)
        pitchLadder = PitchLadder(sceneSize: sceneSize, degreeSpacing: 5)
        super.init()
        
        addChild(horizon)
        addChild(pitchLadder)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Gyroscope: AttitudeAdjustable {
    
    func setAttitude(pitch pitch: Float, roll: Float) {
        let x = CGFloat(pitch) * -300
        let rollaction = SKAction.rotateToAngle(CGFloat(roll), duration: 0.05, shortestUnitArc: true)
        let pitchAction = SKAction.moveToY(x, duration: 0.05)
        let sequence = SKAction.sequence([pitchAction,rollaction])
        horizon.runAction(sequence)
        
        pitchLadder.runAction(pitchAction)
    }
}
