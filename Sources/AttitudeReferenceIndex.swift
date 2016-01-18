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
        
        let offset = Constants.Size.AttitudeReferenceIndex.sideBarOffset
        addChild(buildLeftBar(transform: CGAffineTransformMakeTranslation(CGFloat(-offset), 0)))
        addChild(buildLeftBar(transform: CGAffineTransformMake(-1, 0, 0, 1, CGFloat(offset), 0)))
        addChild(buildCenterBar())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildLeftBar(var transform transform: CGAffineTransform) -> SKShapeNode {
        let width = CGFloat(Constants.Size.AttitudeReferenceIndex.sideBarWidth)
        let height = CGFloat(Constants.Size.AttitudeReferenceIndex.sideBarHeight)
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -width, 2)
        CGPathAddLineToPoint(path, nil, 0, 2)
        CGPathAddLineToPoint(path, nil, 0, -height)
        CGPathAddLineToPoint(path, nil, -4, -height)
        CGPathAddLineToPoint(path, nil, -4, -2)
        CGPathAddLineToPoint(path, nil, -width, -2)
        CGPathCloseSubpath(path)

        let transformedPath = withUnsafeMutablePointer(&transform) {
            CGPathCreateMutableCopyByTransformingPath(path, $0)
        }
        
        let shape = SKShapeNode(path: transformedPath!)
        shape.fillColor = Constants.Color.AttitudeReferenceIndex.shapeFill
        shape.strokeColor = Constants.Color.AttitudeReferenceIndex.shapeStroke
        return shape
    }
    
    private func buildCenterBar() -> SKShapeNode {
        let halfWidth = CGFloat(Constants.Size.AttitudeReferenceIndex.centerBarWidth) / 2
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -halfWidth, 2)
        CGPathAddLineToPoint(path, nil, halfWidth, 2)
        CGPathAddLineToPoint(path, nil, halfWidth, -2)
        CGPathAddLineToPoint(path, nil, -halfWidth, -2)
        CGPathCloseSubpath(path)
        
        let shape = SKShapeNode(path: path)
        shape.fillColor = Constants.Color.AttitudeReferenceIndex.shapeFill
        shape.strokeColor = Constants.Color.AttitudeReferenceIndex.shapeStroke
        return shape
    }
}
