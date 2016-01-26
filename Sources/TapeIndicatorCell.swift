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
    private let style: TapeIndicatorCellStyle
    private let markerNodeName = "TapeIndicatorCellMarkerNoder"
    
    init(model: TapeIndicatorCellModel, style: TapeIndicatorCellStyle) {
        self.model = model
        self.style = style
        super.init()
        createMarkerNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func destroyMarkerNodes() {
        removeChildrenInArray(self[markerNodeName])
    }
    
    private func createMarkerNodes() {
        Array(model.lowerValue...model.upperValue)
            .flatMap({CellMarker(value: $0, style: style)})
            .forEach { marker in
                
                let line = SKShapeNode(rectOfSize: CGSize(width: 0, height: marker.height))
                line.name = markerNodeName
                line.strokeColor = marker.color
                line.fillColor = marker.color
                line.position = CGPoint(
                    x: CGFloat(((marker.value - model.lowerValue) * style.pointsPerValue)) - style.size.width/2,
                    y: (CGFloat(marker.height) - style.size.height)/2)
                addChild(line)
                
                if marker.isMajor {
                    let label = SKLabelNode(text: "\(marker.value)")
                    label.name = markerNodeName
                    label.fontName = Constants.Font.family
                    label.fontSize = Constants.Font.size
                    label.position = CGPoint(
                        x: CGFloat(((marker.value - model.lowerValue) * style.pointsPerValue)) - style.size.width/2,
                        y: CGFloat(style.markerTextOffset) - style.size.height/2)
                    addChild(label)
                }
            }
    }
}

struct CellMarker {
    let value: Int
    let height: Int
    let color: SKColor
    let isMajor: Bool

    init?(value: Int, style: TapeIndicatorCellStyle) {
        let isMajor = value % style.majorMarkerFrequency == 0
        let isMinor = value % style.minorMarkerFrequency == 0
        
        guard isMajor || isMinor else { return nil }
        
        self.value = value
        self.color = style.contentColor
        self.height = isMajor ? style.majorMarkerHeight : style.minorMarkerHeight
        self.isMajor = isMajor
    }
}
