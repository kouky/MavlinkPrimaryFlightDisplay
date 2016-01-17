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
    
    override init() {
        bankArc = BankArc()
        super.init()

        addChild(bankArc)
        addChild(SkyPointer())
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
    
    override init() {
        super.init()
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -CGFloat(Constants.Size.BankIndicator.skyPointerWidth)/2, 0)
        CGPathAddLineToPoint(path, nil, CGFloat(Constants.Size.BankIndicator.skyPointerWidth)/2, 0)
        CGPathAddLineToPoint(path, nil, 0, CGFloat(Constants.Size.BankIndicator.skyPointerHeight))
        CGPathCloseSubpath(path)
        
        let shape = SKShapeNode(path: path)
        shape.fillColor = Constants.Color.BankIndicator.skyPointer
        shape.strokeColor = Constants.Color.BankIndicator.skyPointer
        shape.lineJoin = .Miter
        shape.position = CGPoint(x: 0, y: Constants.Size.BankIndicator.radius - Constants.Size.BankIndicator.skyPointerHeight - Constants.Size.BankIndicator.lineWidth*2)
        addChild(shape)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class BankArc: SKNode {
    
    private let degreeValues = Array((-175).stride(to: 181, by: 5))
 
    override init() {
        assert(Constants.Size.BankIndicator.maximumDisplayDegree > 0, "Bank indicator maximum display degree must be greater than 0")
        assert(Constants.Size.BankIndicator.maximumDisplayDegree <= 180, "Bank indicator maximum display degree must have maximum value of 180")
        super.init()

        let arc = SKShapeNode(circleOfRadius: CGFloat(Constants.Size.BankIndicator.radius))
        let cropNode = SKCropNode()
        let maskNodeEdgeSize = Constants.Size.BankIndicator.radius * 2 + Constants.Size.BankIndicator.lineWidth
        let maskNode = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: maskNodeEdgeSize, height: maskNodeEdgeSize))
        let maxDegree = Constants.Size.BankIndicator.maximumDisplayDegree
        
        arc.lineWidth = CGFloat(Constants.Size.BankIndicator.lineWidth)
        cropNode.addChild(arc)
        cropNode.maskNode = maskNode
        let cropMaskVerticalPosition = CGFloat(cos(Constants.Angular.radiansFromDegrees(CGFloat(maxDegree)))) * CGFloat(Constants.Size.BankIndicator.radius)
        cropNode.maskNode?.position = CGPoint(x: 0, y: CGFloat(Constants.Size.BankIndicator.radius) + cropMaskVerticalPosition)
        addChild(cropNode)
        
        let markers = degreeValues.filter {
            return abs($0) <= maxDegree
        }.map {
            (degree: $0, displayText: "\(abs($0))")
        }
        
        for marker in markers {
            let style: BankArcMarkerStyle = marker.degree % 15 == 0 ? .Major : . Minor
            addChild(BankArcMarker(marker: marker, style: style))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private enum BankArcMarkerStyle {
    case Major
    case Minor
    
    var height: Int {
        switch self {
        case .Major: return Constants.Size.BankIndicator.majorMarkerHeight
        case .Minor: return Constants.Size.BankIndicator.minorMarkerHeight
        }
    }
}

private class BankArcMarker: SKNode {
    
    init(marker: (degree: Int, displayText: String), style: BankArcMarkerStyle) {
        super.init()
        
        let radians = Constants.Angular.radiansFromDegrees(CGFloat(marker.degree))
        let rotateAction = SKAction.rotateByAngle(-radians, duration: 0)
        
        let height = (style == .Major ? Constants.Size.BankIndicator.majorMarkerHeight : Constants.Size.BankIndicator.minorMarkerHeight)
        let line = SKShapeNode(rectOfSize: CGSize(width: 0, height: height))
        line.strokeColor = Constants.Color.BankIndicator.line
        line.fillColor = Constants.Color.BankIndicator.line
        let offset = CGFloat(Constants.Size.BankIndicator.radius + (height / 2))
        let displacement = SKAction.moveBy(CGVector(dx: offset * sin(radians), dy: offset * cos(radians)), duration: 0)
        line.runAction(SKAction.sequence([rotateAction, displacement]))
        line.antialiased = true
        addChild(line)
        
        if style == .Major {
            let label = SKLabelNode(text: marker.displayText)
            label.fontName = Constants.Font.family
            label.fontSize = Constants.Font.size
            label.fontColor = Constants.Color.BankIndicator.text
            
            let offset = CGFloat(Constants.Size.BankIndicator.radius + Constants.Size.BankIndicator.markerTextOffset)
            let displacement = SKAction.moveBy(CGVector(dx: offset * sin(radians), dy: offset * cos(radians)), duration: 0)
            label.runAction(SKAction.sequence([rotateAction, displacement]))
            addChild(label)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}