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
    
    enum TapeRange {
        case Loop(range: Range<Int>)
        case Continuous
    }

    let size: CGSize
    let range: TapeRange
    let pointsPerValue: Int
    
    let cellJustification: CellJustification
    let cellMajorMarkerLength: Int
    let cellMinorMarkerLength: Int
    let cellMajorMarkerFrequency: Int
    let cellMinorMarkerFrequency: Int
    let cellMarkerTextOffset: Int
    
    let backgroundColor: SKColor
    let contentColor: SKColor
    
    var optimalCellValueRange: Int {
        switch cellJustification {
        case .Bottom, .Top:
            return Int(floor(size.width / CGFloat(pointsPerValue)))
        case .Left, .Right:
            return Int(floor(size.height / CGFloat(pointsPerValue)))
        }
    }
}
