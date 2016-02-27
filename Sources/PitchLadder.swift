//
//  PitchLadder.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 5/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class PitchLadder: SKNode {
    
    let sceneSize: CGSize
    private let degreeValues = Array(5.stride(to: 91, by: 5))
    private let cropNode = SKCropNode()
    private let maskNode: SKSpriteNode
    
    init(sceneSize: CGSize) {
        self.sceneSize = sceneSize
        let maskSize = CGSize(
            width: CGFloat(Constants.Size.PitchLadder.majorLineWidth) * 3.0,
            height: sceneSize.pointsPerDegree * 44)
        self.maskNode = SKSpriteNode(color: SKColor.blackColor(), size: maskSize)
        super.init()
        
        let skyPitchLines = degreeValues.map { degree in
            return (degree, (degree % 10 == 0) ? PitchLineStyle.Major : PitchLineStyle.Minor)
        }
        let pitchLines = skyPitchLines + skyPitchLines.map { ($0.0 * -1, $0.1) }
        for (degree, style) in pitchLines {
            cropNode.addChild(PitchLineBuilder.pitchLine(sceneSize: sceneSize, degree: degree, style: style))
        }
        for (degree, style) in pitchLines.filter({ $1 == .Major }) {
            cropNode.addChild(PitchLineBuilder.leftPitchLineLabel(sceneSize: sceneSize, degree: degree, style: style))
            cropNode.addChild(PitchLineBuilder.rightPitchLineLabel(sceneSize: sceneSize, degree: degree, style: style))
        }
        
        cropNode.maskNode = maskNode
        addChild(cropNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PitchLadder: AttitudeSettable {
    
    func setAttitude(attitude: AttitudeType) {
        cropNode.runAction(attitude.pitchAction(sceneSize: sceneSize))
        maskNode.runAction(attitude.pitchReverseAction(sceneSize: sceneSize))
        runAction(attitude.rollAction())
    }
}

private enum PitchLineStyle {
    case Major
    case Minor
    
    var width: Int {
        switch self {
        case .Major: return Constants.Size.PitchLadder.majorLineWidth
        case .Minor: return Constants.Size.PitchLadder.minorLineWidth
        }
    }
}

private struct PitchLineBuilder {
    
    static func pitchLine(sceneSize sceneSize: CGSize, degree: Int, style: PitchLineStyle) -> SKShapeNode {
        
        let halfWidth = CGFloat(style.width) / 2
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -halfWidth, 2)
        CGPathAddLineToPoint(path, nil, halfWidth, 2)
        CGPathAddLineToPoint(path, nil, halfWidth, -2)
        CGPathAddLineToPoint(path, nil, -halfWidth, -2)
        CGPathCloseSubpath(path)
        
        var transform = CGAffineTransformMakeTranslation(0, CGFloat(degree) * sceneSize.pointsPerDegree)
        let transformedPath = withUnsafeMutablePointer(&transform) {
            CGPathCreateMutableCopyByTransformingPath(path, $0)
        }

        let line = SKShapeNode(path: transformedPath!)
        line.fillColor = Constants.Color.PitchLadder.line
        line.strokeColor = SKColor.blackColor()
        return line
    }
    
    static func leftPitchLineLabel(sceneSize sceneSize: CGSize, degree: Int, style: PitchLineStyle) -> SKLabelNode {
        let label = pitchLineLabel(sceneSize: sceneSize, degree: degree, style: style)
        label.horizontalAlignmentMode = .Right
        let halfWidth = CGFloat(style.width) / 2
        label.position.x = -halfWidth - CGFloat(Constants.Size.PitchLadder.markerTextOffset)
        return label
    }

    static func rightPitchLineLabel(sceneSize sceneSize: CGSize, degree: Int, style: PitchLineStyle) -> SKLabelNode {
        let label = pitchLineLabel(sceneSize: sceneSize, degree: degree, style: style)
        label.horizontalAlignmentMode = .Left
        let halfWidth = CGFloat(style.width) / 2
        label.position.x = halfWidth + CGFloat(Constants.Size.PitchLadder.markerTextOffset)
        return label
    }

    private static func pitchLineLabel(sceneSize sceneSize: CGSize, degree: Int, style: PitchLineStyle) -> SKLabelNode {
        let label = SKLabelNode(text: "\(degree)")
        label.fontName = Constants.Font.family
        label.fontSize = Constants.Font.size
        label.verticalAlignmentMode = .Center
        label.position.y = CGFloat(degree) * sceneSize.pointsPerDegree
        return label
    }
}
