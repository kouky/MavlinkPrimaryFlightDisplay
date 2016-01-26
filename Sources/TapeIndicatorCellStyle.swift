//
//  TapeIndicatorCellStyle.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 24/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeIndicatorCellStyle {
    
    let size: CGSize
    let pointsPerValue: Int
    let majorMarkerHeight: Int
    let minorMarkerHeight: Int
    let majorMarkerFrequency: Int
    let minorMarkerFrequency: Int
    let markerTextOffset: Int
    let contentColor: SKColor
}

protocol CellStyleConvertible {
    
    var cellStyle: TapeIndicatorCellStyle { get }
}

extension TapeIndicatorStyle: CellStyleConvertible {
    
    var cellStyle: TapeIndicatorCellStyle {
        
        let transformedSize: CGSize
        switch orientation {
        case .Horizontal: transformedSize = cellSize
        case .Vertical: transformedSize = CGSize(width: cellSize.height, height: cellSize.width)
        }
                
        return TapeIndicatorCellStyle(
            size: transformedSize,
            pointsPerValue: pointsPerValue,
            majorMarkerHeight: cellMajorMarkerHeight,
            minorMarkerHeight: cellMinorMarkerHeight,
            majorMarkerFrequency: cellMajorMarkerFrequency,
            minorMarkerFrequency: cellMinorMarkerFrequency,
            markerTextOffset:  cellMarkerTextOffset,
            contentColor: contentColor)
    }
}
