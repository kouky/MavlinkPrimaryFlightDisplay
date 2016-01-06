//
//  PitchLadder.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 5/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class PitchLadder: SKNode {
    
    private let minorPitchLineWidth = 20
    private let majorPitchLineWidth = 60
    private let minorPitchDegreeValues = Array(5.stride(to: 86, by: 10))
    private let majorPitchDegreeValues = Array(10.stride(to: 91, by: 10))
    private let pitchLines = SKNode()

    init(sceneSize: CGSize, degreeSpacing: Int) {
        super.init()
        
        for degree in majorPitchDegreeValues {
            pitchLines.addChild(PitchLineBuilder.pitchLineForDegree(degree, width: majorPitchLineWidth, degreeSpacing: degreeSpacing))
        }

        for degree in majorPitchDegreeValues.map({ $0 * -1 }) {
            pitchLines.addChild(PitchLineBuilder.pitchLineForDegree(degree, width: majorPitchLineWidth, degreeSpacing: degreeSpacing))
        }
        
        for degree in minorPitchDegreeValues {
            pitchLines.addChild(PitchLineBuilder.pitchLineForDegree(degree, width: minorPitchLineWidth, degreeSpacing: degreeSpacing))
        }

        for degree in minorPitchDegreeValues.map({ $0 * -1 }) {
            pitchLines.addChild(PitchLineBuilder.pitchLineForDegree(degree, width: minorPitchLineWidth, degreeSpacing: degreeSpacing))
        }

        addChild(pitchLines)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct PitchLineBuilder {
    
    static func pitchLineForDegree(degree: Int, width: Int, degreeSpacing: Int) -> SKShapeNode {
        let halfWidth = CGFloat(width) / 2
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -halfWidth, 2)
        CGPathAddLineToPoint(path, nil, halfWidth, 2)
        CGPathAddLineToPoint(path, nil, halfWidth, -2)
        CGPathAddLineToPoint(path, nil, -halfWidth, -2)
        CGPathCloseSubpath(path)
        
        var transform = CGAffineTransformMakeTranslation(0, CGFloat(degree * degreeSpacing))
        let transformedPath = withUnsafeMutablePointer(&transform) {
            CGPathCreateMutableCopyByTransformingPath(path, $0)
        }

        let line = SKShapeNode(path: transformedPath!)
        line.fillColor = fillColor()
        line.strokeColor = SKColor.blackColor()
        return line
    }
    
    private static func fillColor() -> SKColor {
        return SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
}

extension PitchLadder: AttitudeAdjustable {
    
    func setAttitude(pitch pitch: Float, roll: Float) {
        
        let x = CGFloat(pitch) * -300
        let rollAction = SKAction.rotateToAngle(CGFloat(roll), duration: 0.05, shortestUnitArc: true)
        let pitchAction = SKAction.moveToY(x, duration: 0.05)
     
        pitchLines.runAction(pitchAction)
        runAction(rollAction)
    }
}