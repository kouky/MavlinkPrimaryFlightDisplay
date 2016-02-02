//
//  TapeCell.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 23/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeCellModel {
    let lowerValue: Int
    let upperValue: Int
    
    var midValue: Double {
        let halfRange = (Double(upperValue) - Double(lowerValue)) / 2
        return Double(lowerValue) + halfRange
    }
    
    var range: UInt {
        return UInt(upperValue - lowerValue)
    }
}

class TapeCell: SKNode {
    
    var model: TapeCellModel {
        didSet {
            removeAllChildren()
            createMarkerNodes()
        }
    }
    private let cellStyle: TapeCellStyle
    
    init(model: TapeCellModel, style: TapeCellStyle) {
        self.model = model
        self.cellStyle = style
        super.init()
        createMarkerNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func actionForValue(value: Double) -> SKAction {
        let valuePosition = (model.midValue - value) * Double(cellStyle.pointsPerValue)
        switch cellStyle.justification {
        case .Top, .Bottom:
            return SKAction.moveToX(CGFloat(valuePosition), duration: 0.05)
        case .Left, .Right:
            return SKAction.moveToY(CGFloat(valuePosition), duration: 0.05)
        }
    }
    
    func containsValue(value: Double) -> Bool {
        return Double(model.lowerValue) <= value && value <= Double(model.upperValue)
    }
    
    func distanceFromValue(value: Int) -> Double {
        return abs(model.midValue - Double(value))
    }
    
    private func createMarkerNodes() {
        Array(model.lowerValue...model.upperValue)
            .flatMap({CellMarker(value: $0, cellStyle: cellStyle)})
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
        
        switch cellStyle.justification {
        case .Top:
            line.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - (CGFloat(model.range) * CGFloat(cellStyle.pointsPerValue))/2,
                y: (cellStyle.size.height - CGFloat(marker.lineSize.height))/2)
        case .Bottom:
            line.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - (CGFloat(model.range) * CGFloat(cellStyle.pointsPerValue))/2,
                y: (CGFloat(marker.lineSize.height) - cellStyle.size.height)/2)
        case .Left:
            line.position = CGPoint(
                x: (CGFloat(marker.lineSize.width) - cellStyle.size.width)/2,
                y: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - (CGFloat(model.range) * CGFloat(cellStyle.pointsPerValue))/2)
        case .Right:
            line.position = CGPoint(
                x: (cellStyle.size.width - CGFloat(marker.lineSize.width))/2,
                y: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - (CGFloat(model.range) * CGFloat(cellStyle.pointsPerValue))/2)
        }
        
        return line
    }
    
    private func buildLabelNode(marker: CellMarker) -> SKLabelNode {
        let label = SKLabelNode(text: "\(marker.value)")
        label.fontName = Constants.Font.family
        label.fontSize = Constants.Font.size
        label.horizontalAlignmentMode = marker.labelAlignment.horizontal
        label.verticalAlignmentMode = marker.labelAlignment.vertical
        
        switch cellStyle.justification {
        case .Top:
            label.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - cellStyle.size.width/2,
                y: cellStyle.size.height/2 - CGFloat(cellStyle.markerTextOffset))
        case .Bottom:
            label.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - cellStyle.size.width/2,
                y: CGFloat(cellStyle.markerTextOffset) - cellStyle.size.height/2)
        case .Left:
            label.position = CGPoint(
                x: CGFloat(cellStyle.markerTextOffset) - cellStyle.size.width/2,
                y: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - cellStyle.size.height/2)
        case .Right:
            label.position = CGPoint(
                x: cellStyle.size.width/2 - CGFloat(cellStyle.markerTextOffset),
                y: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - cellStyle.size.height/2)
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

    init?(value: Int, cellStyle: TapeCellStyle) {
        let isMajor = value % cellStyle.majorMarkerFrequency == 0
        let isMinor = value % cellStyle.minorMarkerFrequency == 0
        
        guard isMajor || isMinor else { return nil }
        
        self.value = value
        self.color = cellStyle.contentColor
        self.isMajor = isMajor
        
        let length = isMajor ? cellStyle.majorMarkerLength : cellStyle.minorMarkerLength
        switch cellStyle.justification {
        case .Top, .Bottom: lineSize = CGSize(width: 0, height: length)
        case .Left, .Right: lineSize = CGSize(width: length, height: 0)
        }
        
        switch cellStyle.justification {
        case .Top: labelAlignment = (horizontal: .Center, vertical: .Top)
        case .Bottom: labelAlignment = (horizontal: .Center, vertical: .Bottom)
        case .Left: labelAlignment = (horizontal: .Left, vertical: .Center)
        case .Right: labelAlignment = (horizontal: .Right, vertical: .Center)
        }
    }
}
