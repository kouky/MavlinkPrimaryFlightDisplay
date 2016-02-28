//
//  TapePointer.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 23/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class TapePointer: SKNode {
    

    var style: TapeIndicatorStyleType
    private let label: SKLabelNode
    
    var value: Int {
        didSet {
            label.text = style.labelForValue(value)
        }
    }
    
    init(initialValue: Int, style: TapeIndicatorStyleType) {
        self.value = initialValue
        self.style = style
        label = SKLabelNode(text: style.labelForValue(value))
        super.init()
        
        addChild(buildBackgroundShape())
        styleLabelNode()
        addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleLabelNode() {
        label.fontName = style.font.family
        label.fontSize = style.font.size
        label.color = style.markerTextColor
        
        switch style.markerJustification {
        case .Top:
            label.horizontalAlignmentMode = .Center
            label.verticalAlignmentMode = .Top
            label.position = CGPoint(x: 0, y: style.size.height/2 - CGFloat(style.markerTextOffset))
        case .Bottom:
            label.horizontalAlignmentMode = .Center
            label.verticalAlignmentMode = .Bottom
            label.position = CGPoint(x: 0, y: CGFloat(style.markerTextOffset) - style.size.height/2)
        case .Left:
            label.horizontalAlignmentMode = .Left
            label.verticalAlignmentMode = .Center
            label.position = CGPoint(x: CGFloat(style.markerTextOffset) - style.size.width/2, y: 0)
        case .Right:
            label.horizontalAlignmentMode = .Right
            label.verticalAlignmentMode = .Center
            label.position = CGPoint(x: style.size.width/2 - CGFloat(style.markerTextOffset), y: 0)
        }
    }
    
    private func buildBackgroundShape() -> SKShapeNode {
        let width, halfWidth, thirdWidth: CGFloat
        
        switch style.markerJustification {
        case .Top, .Bottom:
            width = CGFloat(style.size.height)
            halfWidth = width / 2
            thirdWidth = width / 3
        case .Left, .Right:
            width = style.size.width
            halfWidth = width / 2
            thirdWidth = width / 3
        }
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddLineToPoint(path, nil, thirdWidth, thirdWidth)
        CGPathAddLineToPoint(path, nil, width, thirdWidth)
        CGPathAddLineToPoint(path, nil, width, -thirdWidth)
        CGPathAddLineToPoint(path, nil, thirdWidth, -thirdWidth)
        CGPathCloseSubpath(path)
        
        let translateTransform, rotateTransform: CGAffineTransform

        switch style.markerJustification {
        case .Top:
            translateTransform = CGAffineTransformMakeTranslation(-halfWidth, 0)
            rotateTransform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        case .Bottom:
            translateTransform = CGAffineTransformMakeTranslation(-halfWidth, 0)
            rotateTransform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        case .Left:
            translateTransform = CGAffineTransformMakeTranslation(-halfWidth, 0)
            rotateTransform = CGAffineTransformIdentity
        case .Right:
            translateTransform = CGAffineTransformMakeTranslation(-halfWidth, 0)
            rotateTransform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        }
        
        var transform = CGAffineTransformConcat(translateTransform, rotateTransform)
        let transformedPath = withUnsafeMutablePointer(&transform) {
            CGPathCreateMutableCopyByTransformingPath(path, $0)
        }
        
        let shape = SKShapeNode(path: transformedPath!)
        shape.fillColor = style.pointerBackgroundColor
        shape.strokeColor = SKColor.whiteColor()
        return shape
    }
}
