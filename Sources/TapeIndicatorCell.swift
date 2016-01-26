//
//  TapeIndicatorCell.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 23/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeIndicatorCellModel {
    let lowerValue: Int
    let upperValue: Int
}

class TapeIndicatorCell: SKNode {
    
    var model: TapeIndicatorCellModel {
        didSet {
            destroyMarkerNodes()
            createMarkerNodes()
        }
    }
    private let cellStyle: TapeIndicatorCellStyle
    private let cellNodeName = "TapeIndicatorCellNode"
    
    init(model: TapeIndicatorCellModel, style: TapeIndicatorCellStyle) {
        self.model = model
        self.cellStyle = style
        super.init()
        createMarkerNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func destroyMarkerNodes() {
        removeChildrenInArray(self[cellNodeName])
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
        line.name = cellNodeName
        line.strokeColor = marker.color
        line.fillColor = marker.color
        
        switch cellStyle.justification {
        case .Top:
            line.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - cellStyle.size.width/2,
                y: (cellStyle.size.height - CGFloat(marker.lineSize.height))/2)
        case .Bottom:
            line.position = CGPoint(
                x: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - cellStyle.size.width/2,
                y: (CGFloat(marker.lineSize.height) - cellStyle.size.height)/2)
        case .Left:
            line.position = CGPoint(
                x: (CGFloat(marker.lineSize.width) - cellStyle.size.width)/2,
                y: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - cellStyle.size.height/2)
        case .Right:
            line.position = CGPoint(
                x: (cellStyle.size.width - CGFloat(marker.lineSize.width))/2,
                y: CGFloat(((marker.value - model.lowerValue) * cellStyle.pointsPerValue)) - cellStyle.size.height/2)
        }
        
        return line
    }
    
    private func buildLabelNode(marker: CellMarker) -> SKLabelNode {
        let label = SKLabelNode(text: "\(marker.value)")
        label.name = cellNodeName
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

struct CellMarker {
    let value: Int
    let lineSize: CGSize
    let color: SKColor
    let isMajor: Bool
    let labelAlignment: (horizontal: SKLabelHorizontalAlignmentMode, vertical: SKLabelVerticalAlignmentMode)

    init?(value: Int, cellStyle: TapeIndicatorCellStyle) {
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
