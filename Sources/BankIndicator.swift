//
//  BankIndicator.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 14/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit
import Darwin

class BankIndicator: SKNode {
    
    private let bankArc: BankArc
    
    init(style: BankIndicatorStyleType) {
        bankArc = BankArc(style: style)
        super.init()

        addChild(bankArc)
        addChild(SkyPointer(style: style))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BankIndicator: AttitudeSettable {
    
    func setAttitude(attitude: AttitudeType) {
        bankArc.runAction(attitude.rollAction())
    }
}

private class SkyPointer: SKNode {
    
    init(style: BankIndicatorStyleType) {
        super.init()
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -CGFloat(style.skyPointerWidth)/2, 0)
        CGPathAddLineToPoint(path, nil, CGFloat(style.skyPointerWidth)/2, 0)
        CGPathAddLineToPoint(path, nil, 0, CGFloat(style.skyPointerHeight))
        CGPathCloseSubpath(path)
        
        let shape = SKShapeNode(path: path)
        shape.fillColor = style.skyPointerFillColor
        shape.strokeColor = style.skyPointerFillColor
        shape.lineJoin = .Miter
        shape.position = CGPoint(x: 0, y: style.arcRadius - style.skyPointerHeight - style.arcLineWidth*2)
        addChild(shape)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class BankArc: SKNode {
    
    private let degreeValues = Array((-175).stride(to: 181, by: 5))
    private let style: BankIndicatorStyleType
    
    init(style: BankIndicatorStyleType) {
        assert(style.arcMaximumDisplayDegree > 0, "Bank indicator maximum display degree must be greater than 0")
        assert(style.arcMaximumDisplayDegree <= 180, "Bank indicator maximum display degree must have maximum value of 180")
        self.style = style
        super.init()

        addMaskedArc()
        addMarkers()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addMaskedArc() {
        let arc = SKShapeNode(circleOfRadius: CGFloat(style.arcRadius))
        let cropNode = SKCropNode()
        let maskNodeEdgeSize = style.arcRadius * 2 + style.arcLineWidth
        let maskNode = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: maskNodeEdgeSize, height: maskNodeEdgeSize))
        let maxDegree = style.arcMaximumDisplayDegree
        
        arc.lineWidth = CGFloat(style.arcLineWidth)
        cropNode.addChild(arc)
        cropNode.maskNode = maskNode
        let cropMaskVerticalPosition = cos(maxDegree.radians) * CGFloat(style.arcRadius)
        cropNode.maskNode?.position = CGPoint(x: 0, y: CGFloat(style.arcRadius) + cropMaskVerticalPosition)
        addChild(cropNode)
    }
    
    private func addMarkers() {
        degreeValues.filter {
            abs($0) <= style.arcMaximumDisplayDegree
        }.map {
            (degree: $0, displayText: "\(abs($0))")
        }.forEach { marker in
            let type: BankArcMarkerType = marker.degree % 15 == 0 ? .Major : . Minor
            addChild(BankArcMarker(marker: marker, type: type, style: style))
        }
    }
}

private enum BankArcMarkerType {
    case Major
    case Minor
}

private class BankArcMarker: SKNode {
    
    init(marker: (degree: Int, displayText: String), type: BankArcMarkerType, style: BankIndicatorStyleType) {
        super.init()
        
        let radians = marker.degree.radians
        let rotateAction = SKAction.rotateByAngle(-radians, duration: 0)
        let moveAction = { (offset: CGFloat) -> SKAction in
            SKAction.moveBy(CGVector(dx: offset * sin(radians), dy: offset * cos(radians)), duration: 0)
        }
        
        let height = (type == .Major ? style.majorMarkerHeight : style.minorMarkerHeight)
        let line = SKShapeNode(rectOfSize: CGSize(width: 0, height: height))
        line.strokeColor = style.arcStrokeColor
        line.fillColor = style.arcStrokeColor
        let offset = CGFloat(style.arcRadius + (height / 2))
        line.runAction(SKAction.sequence([rotateAction, moveAction(offset)]))
        line.antialiased = true
        addChild(line)
        
        if type == .Major {
            let label = SKLabelNode(text: marker.displayText)
            label.fontName = Constants.Font.family
            label.fontSize = Constants.Font.size
            label.fontColor = style.textColor
            
            let offset = CGFloat(style.arcRadius + style.markerTextOffset)
            label.runAction(SKAction.sequence([rotateAction, moveAction(offset)]))
            addChild(label)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}