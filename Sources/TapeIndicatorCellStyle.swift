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
    let cellMajorMarkerHeight: Int
    let cellMinorMarkerHeight: Int
    let cellMajorMarkerFrequency: Int
    let cellMinorMarkerFrequency: Int
    let contentColor: SKColor
}

protocol CellStyleConvertible {
    
    var cellStyle: TapeIndicatorCellStyle { get }
}

extension TapeIndicatorStyle: CellStyleConvertible {
    
    var cellStyle: TapeIndicatorCellStyle {
        
        return TapeIndicatorCellStyle(
            size: cellSize,
            pointsPerValue: pointsPerValue,
            cellMajorMarkerHeight: cellMajorMarkerHeight,
            cellMinorMarkerHeight: cellMinorMarkerHeight,
            cellMajorMarkerFrequency: cellMajorMarkerFrequency,
            cellMinorMarkerFrequency: cellMinorMarkerFrequency,
            contentColor: contentColor)
    }
}
