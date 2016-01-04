//
//  AttitudeReferenceIndex.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 4/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

public enum AttitudeReferenceIndexStyle {
    case Bars
    case Nose
}

class AttitudeReferenceIndex: SKNode {
    init(style: AttitudeReferenceIndexStyle = .Bars) {
        super.init()
        switch style {
        case .Bars: addChild(Bars())
        case .Nose: addChild(Nose())
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class Bars: SKNode {
    
    override init() {
        super.init()
        
        let left = buildLeftBar(transform: CGAffineTransformMakeTranslation(-40, 0))
        addChild(left)
        
        let right = buildLeftBar(transform: CGAffineTransformMake(-1, 0, 0, 1, 40, 0))
        addChild(right)
        
        addChild(buildCenterBar())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildLeftBar(var transform transform: CGAffineTransform) -> SKShapeNode {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -100, 2)
        CGPathAddLineToPoint(path, nil, 0, 2)
        CGPathAddLineToPoint(path, nil, 0, -10)
        CGPathAddLineToPoint(path, nil, -4, -10)
        CGPathAddLineToPoint(path, nil, -4, -2)
        CGPathAddLineToPoint(path, nil, -100, -2)
        CGPathAddLineToPoint(path, nil, -100, 2)

        let transformedPath = withUnsafeMutablePointer(&transform) {
            CGPathCreateMutableCopyByTransformingPath(path, $0)
        }
        
        let shape = SKShapeNode(path: transformedPath!)
        shape.fillColor = SKColor.whiteColor()
        shape.strokeColor = SKColor.blackColor()
        return shape
    }
    
    func buildCenterBar() -> SKShapeNode {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -5, 2)
        CGPathAddLineToPoint(path, nil, 5, 2)
        CGPathAddLineToPoint(path, nil, 5, -2)
        CGPathAddLineToPoint(path, nil, -5, -2)
        CGPathAddLineToPoint(path, nil, -5, 2)
        
        let shape = SKShapeNode(path: path)
        shape.fillColor = SKColor.whiteColor()
        shape.strokeColor = SKColor.blackColor()
        return shape
    }
}

private class Nose: SKNode {
    override init() {
        super.init()
        // TODO: Implement
        addChild(SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 20, height: 20)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
