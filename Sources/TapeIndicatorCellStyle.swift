//
//  TapeIndicatorCellStyle.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 24/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeIndicatorCellStyle {

    enum Justification {
        case Top
        case Bottom
        case Left
        case Right
    }

    let size: CGSize
    let justification: Justification
    let pointsPerValue: Int
    let majorMarkerLength: Int
    let minorMarkerLength: Int
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
        
        let justification: TapeIndicatorCellStyle.Justification
        switch cellJustification {
        case .Top: justification = .Top
        case .Bottom: justification = .Bottom
        case .Left: justification = .Left
        case .Right: justification = .Right
        }
        
        return TapeIndicatorCellStyle(
            size: cellSize,
            justification: justification,
            pointsPerValue: pointsPerValue,
            majorMarkerLength: cellMajorMarkerLength,
            minorMarkerLength: cellMinorMarkerLength,
            majorMarkerFrequency: cellMajorMarkerFrequency,
            minorMarkerFrequency: cellMinorMarkerFrequency,
            markerTextOffset:  cellMarkerTextOffset,
            contentColor: contentColor)
    }
}
