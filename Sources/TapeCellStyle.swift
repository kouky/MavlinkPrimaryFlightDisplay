//
//  TapeCellStyle.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 24/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeCellStyle {

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

protocol TapeCellStyleConvertible {
    
    var cellStyle: TapeCellStyle { get }
}

extension TapeIndicatorStyle: TapeCellStyleConvertible {
    
    var cellStyle: TapeCellStyle {
        
        let justification: TapeCellStyle.Justification
        switch cellJustification {
        case .Top: justification = .Top
        case .Bottom: justification = .Bottom
        case .Left: justification = .Left
        case .Right: justification = .Right
        }
        
        return TapeCellStyle(
            size: size,
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
