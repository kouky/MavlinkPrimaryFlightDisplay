//
//  TapeCell.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 23/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

class TapeCell: SKNode {
    
    var model: TapeCellModelType {
        didSet {
            removeAllChildren()
            createMarkerNodes()
        }
    }
    private let style: TapeStyle
    
    init(model: TapeCellModelType, style: TapeStyle) {
        self.model = model
        self.style = style
        super.init()
        createMarkerNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func positionForValue(value: Double) -> CGPoint {
        let valuePosition = (model.midValue - value) * Double(style.markerStyle.pointsPerValue)
        switch style.markerStyle.justification {
        case .Top, .Bottom:
            return CGPoint(x: CGFloat(valuePosition), y: position.y)
        case .Left, .Right:
            return CGPoint(x: position.x, y: CGFloat(valuePosition))
        }
    }
    
    private func createMarkerNodes() {
        Array(model.lowerValue..<model.upperValue)
            .flatMap({CellMarker(value: $0, style: style)})
            .forEach { marker in
                addChild(buildLineNode(marker))
                
                if marker.isMajor {
                    addChild(buildLabelNode(marker))
                }
            }
    }
    
    private func buildLineNode(marker: CellMarker) -> SKShapeNode {
        let line =  SKShapeNode(rectOfSize: marker.lineSize)
        line.strokeColor = marker.color
        line.fillColor = marker.color
        
        switch style.markerStyle.justification {
        case .Top:
            line.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * Int(style.markerStyle.pointsPerValue))) - (CGFloat(model.magnitude) * CGFloat(style.markerStyle.pointsPerValue))/2,
                y: (style.size.height - CGFloat(marker.lineSize.height))/2)
        case .Bottom:
            line.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * Int(style.markerStyle.pointsPerValue))) - (CGFloat(model.magnitude) * CGFloat(style.markerStyle.pointsPerValue))/2,
                y: (CGFloat(marker.lineSize.height) - style.size.height)/2)
        case .Left:
            line.position = CGPoint(
                x: (CGFloat(marker.lineSize.width) - style.size.width)/2,
                y: CGFloat(((marker.value - model.lowerValue) * Int(style.markerStyle.pointsPerValue))) - (CGFloat(model.magnitude) * CGFloat(style.markerStyle.pointsPerValue))/2)
        case .Right:
            line.position = CGPoint(
                x: (style.size.width - CGFloat(marker.lineSize.width))/2,
                y: CGFloat(((marker.value - model.lowerValue) * Int(style.markerStyle.pointsPerValue))) - (CGFloat(model.magnitude) * CGFloat(style.markerStyle.pointsPerValue))/2)
        }
        
        return line
    }
    
    private func buildLabelNode(marker: CellMarker) -> SKLabelNode {
        let label = SKLabelNode(text: style.type.labelForValue(marker.value))
        label.fontName = Constants.Font.family
        label.fontSize = Constants.Font.size
        label.horizontalAlignmentMode = marker.labelAlignment.horizontal
        label.verticalAlignmentMode = marker.labelAlignment.vertical
        
        switch style.markerStyle.justification {
        case .Top:
            label.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * Int(style.markerStyle.pointsPerValue))) - (CGFloat(model.magnitude) * CGFloat(style.markerStyle.pointsPerValue))/2,
                y: style.size.height/2 - CGFloat(style.markerStyle.textOffset))
        case .Bottom:
            label.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * Int(style.markerStyle.pointsPerValue))) - (CGFloat(model.magnitude) * CGFloat(style.markerStyle.pointsPerValue))/2,
                y: CGFloat(style.markerStyle.textOffset) - style.size.height/2)
        case .Left:
            label.position = CGPoint(
                x: CGFloat(style.markerStyle.textOffset) - style.size.width/2,
                y: CGFloat(((marker.value - model.lowerValue) * Int(style.markerStyle.pointsPerValue))) - (CGFloat(model.magnitude) * CGFloat(style.markerStyle.pointsPerValue))/2)
        case .Right:
            label.position = CGPoint(
                x: style.size.width/2 - CGFloat(style.markerStyle.textOffset),
                y: CGFloat(((marker.value - model.lowerValue) * Int(style.markerStyle.pointsPerValue))) - (CGFloat(model.magnitude) * CGFloat(style.markerStyle.pointsPerValue))/2)
        }

        return label
    }
}

private struct CellMarker {
    let value: Int
    let lineSize: CGSize
    let color: SKColor
    let isMajor: Bool
    let labelAlignment: (horizontal: SKLabelHorizontalAlignmentMode, vertical: SKLabelVerticalAlignmentMode)

    init?(value: Int, style: TapeStyle) {
        let isMajor = value % style.markerStyle.majorMarkerFrequency == 0
        let isMinor = value % style.markerStyle.minorMarkerFrequency == 0
        
        guard isMajor || isMinor else { return nil }
        
        self.value = value
        self.color = style.markerStyle.color
        self.isMajor = isMajor
        
        let length = isMajor ? style.markerStyle.majorMarkerLength : style.markerStyle.minorMarkerLength
        switch style.markerStyle.justification {
        case .Top, .Bottom: lineSize = CGSize(width: 0, height: length)
        case .Left, .Right: lineSize = CGSize(width: length, height: 0)
        }
        
        switch style.markerStyle.justification {
        case .Top: labelAlignment = (horizontal: .Center, vertical: .Top)
        case .Bottom: labelAlignment = (horizontal: .Center, vertical: .Bottom)
        case .Left: labelAlignment = (horizontal: .Left, vertical: .Center)
        case .Right: labelAlignment = (horizontal: .Right, vertical: .Center)
        }
    }
}
