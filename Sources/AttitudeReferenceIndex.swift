//
//  AttitudeReferenceIndex.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 4/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class AttitudeReferenceIndex: SKNode {
    
    override init() {
        super.init()
        
        // TODO: Extract 40 offset
        let left = buildLeftBar(transform: CGAffineTransformMakeTranslation(-40, 0))
        addChild(left)
        
        let right = buildLeftBar(transform: CGAffineTransformMake(-1, 0, 0, 1, 40, 0))
        addChild(right)
        
        addChild(buildCenterBar())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildLeftBar(var transform transform: CGAffineTransform) -> SKShapeNode {
        // TODO: Extract size and color
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -100, 2)
        CGPathAddLineToPoint(path, nil, 0, 2)
        CGPathAddLineToPoint(path, nil, 0, -10)
        CGPathAddLineToPoint(path, nil, -4, -10)
        CGPathAddLineToPoint(path, nil, -4, -2)
        CGPathAddLineToPoint(path, nil, -100, -2)
        CGPathAddLineToPoint(path, nil, -100, 2)
        CGPathCloseSubpath(path)

        let transformedPath = withUnsafeMutablePointer(&transform) {
            CGPathCreateMutableCopyByTransformingPath(path, $0)
        }
        
        let shape = SKShapeNode(path: transformedPath!)
        shape.fillColor = SKColor.whiteColor()
        shape.strokeColor = SKColor.blackColor()
        return shape
    }
    
    private func buildCenterBar() -> SKShapeNode {
        // TODO: Extract size and color
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -5, 2)
        CGPathAddLineToPoint(path, nil, 5, 2)
        CGPathAddLineToPoint(path, nil, 5, -2)
        CGPathAddLineToPoint(path, nil, -5, -2)
        CGPathAddLineToPoint(path, nil, -5, 2)
        CGPathCloseSubpath(path)
        
        let shape = SKShapeNode(path: path)
        shape.fillColor = SKColor.whiteColor()
        shape.strokeColor = SKColor.blackColor()
        return shape
    }
}
