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
    func pitchAction(sceneSize sceneSize: CGSize) -> SKAction
    func pitchReverseAction(sceneSize sceneSize: CGSize) -> SKAction
}

protocol AttitudeSettable {
    func setAttitude(attitude: AttitudeType)
}

extension AttitudeType {
    func rollAction() -> SKAction {
        return SKAction.rotateToAngle(CGFloat(rollRadians), duration: 0.05, shortestUnitArc: true)
    }
    
    func pitchAction(sceneSize sceneSize: CGSize) -> SKAction {
        let displacement = CGFloat(pitchRadians) * -1 * Constants.Angular.pointsPerRadianForSceneSize(sceneSize)
        return SKAction.moveToY(displacement, duration: 0.05)
    }
    
    func pitchReverseAction(sceneSize sceneSize: CGSize) -> SKAction {
        let displacement = CGFloat(pitchRadians) * Constants.Angular.pointsPerRadianForSceneSize(sceneSize)
        return SKAction.moveToY(displacement, duration: 0.05)
    }
}
