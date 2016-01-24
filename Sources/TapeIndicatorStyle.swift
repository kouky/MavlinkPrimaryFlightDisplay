//
//  TapeIndicatorStyle.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 24/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeIndicatorStyle {
    
    enum Orientation {
        case Vertical
        case Horizontal
    }
    
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
    let startValue: Int
    let orientation: Orientation
    let range: TapeRange
    let pointsPerValue: Int
    
    let cellJustification: CellJustification
    let cellMajorMarkerHeight: Int
    let cellMinorMarkerHeight: Int
    let cellMajorMarkerFrequency: Int
    let cellMinorMarkerFrequency: Int
    var cellSize: CGSize { return size }
    
    let backgroundColor: SKColor
    let contentColor: SKColor
}
