//
//  Protocols.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 7/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

protocol SceneType {
    var sceneSize: CGSize { get }
}

protocol AttitudeType {
    var rollRadians: Float { get }
    var pitchRadians: Float { get }
    
    func rollAction() -> SKAction
    func pitchAction() -> SKAction
    func pitchReverseAction() -> SKAction
}

protocol AttitudeSettable {
    func setAttitude(attitude: AttitudeType)
}

extension AttitudeType {
    func rollAction() -> SKAction {
        return SKAction.rotateToAngle(CGFloat(rollRadians), duration: 0.05, shortestUnitArc: true)
    }
    
    func pitchAction() -> SKAction {
        return SKAction.moveToY(CGFloat(pitchRadians) * -CGFloat(Constants.Angular.pointsPerRadian), duration: 0.05)
    }
    
    func pitchReverseAction() -> SKAction {
        return SKAction.moveToY(CGFloat(pitchRadians) * CGFloat(Constants.Angular.pointsPerRadian), duration: 0.05)
    }
}
