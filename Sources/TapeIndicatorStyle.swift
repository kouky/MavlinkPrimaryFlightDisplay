//
//  TapeIndicatorStyle.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 24/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeIndicatorStyle {
    
    enum CellJustification {
        case Top
        case Bottom
        case Left
        case Right
    }
    
    enum ValueRange {
        case Compass
        case Continuous
    }
    
    let size: CGSize
    let valueRange: ValueRange
    let pointsPerValue: Int
    
    let cellJustification: CellJustification
    let cellMajorMarkerLength: Int
    let cellMinorMarkerLength: Int
    let cellMajorMarkerFrequency: Int
    let cellMinorMarkerFrequency: Int
    let cellMarkerTextOffset: Int
    
    let backgroundColor: SKColor
    let contentColor: SKColor
    
    var optimalCellMagnitude: Int {
        switch cellJustification {
        case .Bottom, .Top:
            return Int(round(size.width / CGFloat(pointsPerValue)))
        case .Left, .Right:
            return Int(round(size.height / CGFloat(pointsPerValue)))
        }
    }
}
