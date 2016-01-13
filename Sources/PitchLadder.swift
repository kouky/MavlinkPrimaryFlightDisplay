//
//  PitchLadder.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 5/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class PitchLadder: SKNode, SceneType {
    
    let sceneSize: CGSize
    private let minorPitchDegreeValues = Array(5.stride(to: 86, by: 10))
    private let majorPitchDegreeValues = Array(10.stride(to: 91, by: 10))
    private let cropNode = SKCropNode()
    private let maskNode = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: 110, height: 220))
    
    init(sceneSize: CGSize) {
        
        self.sceneSize = sceneSize
        super.init()
        
        cropNode.maskNode = maskNode
        
        for degree in majorPitchDegreeValues {
            cropNode.addChild(PitchLineBuilder.pitchLineForDegree(degree, width: Constants.Size.PitchLadder.majorLineWidth))
        }

        for degree in majorPitchDegreeValues.map({ $0 * -1 }) {
            cropNode.addChild(PitchLineBuilder.pitchLineForDegree(degree, width: Constants.Size.PitchLadder.majorLineWidth))
        }
        
        for degree in minorPitchDegreeValues {
            cropNode.addChild(PitchLineBuilder.pitchLineForDegree(degree, width: Constants.Size.PitchLadder.minorLineWidth))
        }

        for degree in minorPitchDegreeValues.map({ $0 * -1 }) {
            cropNode.addChild(PitchLineBuilder.pitchLineForDegree(degree, width: Constants.Size.PitchLadder.minorLineWidth))
        }

        addChild(cropNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PitchLadder: AttitudeSettable {
    
    func setAttitude(attitude: AttitudeType) {
        cropNode.runAction(attitude.pitchAction())
        maskNode.runAction(attitude.pitchReverseAction())
        runAction(attitude.rollAction())
    }
}

struct PitchLineBuilder {
    
    static func pitchLineForDegree(degree: Int, width: Int) -> SKShapeNode {
        let halfWidth = CGFloat(width) / 2
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -halfWidth, 2)
        CGPathAddLineToPoint(path, nil, halfWidth, 2)
        CGPathAddLineToPoint(path, nil, halfWidth, -2)
        CGPathAddLineToPoint(path, nil, -halfWidth, -2)
        CGPathCloseSubpath(path)
        
        var transform = CGAffineTransformMakeTranslation(0, CGFloat(degree * Constants.Angular.pointsPerDegree))
        let transformedPath = withUnsafeMutablePointer(&transform) {
            CGPathCreateMutableCopyByTransformingPath(path, $0)
        }

        let line = SKShapeNode(path: transformedPath!)
        line.fillColor = Constants.Color.PitchLadder.line
        line.strokeColor = SKColor.blackColor()
        return line
    }
    
    private static func fillColor() -> SKColor {
        return SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
}
