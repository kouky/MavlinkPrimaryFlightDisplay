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

    init(sceneSize: CGSize, degreeSpacing: Int) {
        super.init()
        addChild(PitchLineBuilder.pitchLineForDegree(-5, width: minorPitchLineWidth, degreeSpacing: degreeSpacing))
        addChild(PitchLineBuilder.pitchLineForDegree(-10, width: majorPitchLineWidth, degreeSpacing: degreeSpacing))
        addChild(PitchLineBuilder.pitchLineForDegree(-15, width: minorPitchLineWidth, degreeSpacing: degreeSpacing))
        addChild(PitchLineBuilder.pitchLineForDegree(5, width: minorPitchLineWidth, degreeSpacing: degreeSpacing))
        addChild(PitchLineBuilder.pitchLineForDegree(10, width: majorPitchLineWidth, degreeSpacing: degreeSpacing))
        addChild(PitchLineBuilder.pitchLineForDegree(15, width: minorPitchLineWidth, degreeSpacing: degreeSpacing))
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