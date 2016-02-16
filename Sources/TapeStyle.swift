//
//  TapeStyle.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 16/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeStyle {
    
    enum Type {
        case Compass
        case Continuous
    }
    
    enum Error: ErrorType {
        case InvalidCompassStyle
    }
    
    let size: CGSize
    let type: Type
    let backgroundColor: SKColor
    let markerStyle: TapeMarkerStyle
    
    var optimalCellMagnitude: Int {
        switch markerStyle.justification {
        case .Bottom, .Top:
            return Int(round(size.width / CGFloat(markerStyle.pointsPerValue)))
        case .Left, .Right:
            return Int(round(size.height / CGFloat(markerStyle.pointsPerValue)))
        }
    }
    
    init(size: CGSize, type: Type, backgroundColor: SKColor, markerStyle: TapeMarkerStyle) throws {
        self.size = size
        self.type = type
        self.backgroundColor = backgroundColor
        self.markerStyle = markerStyle

        if type == .Compass && optimalCellMagnitude > 120  {
            throw Error.InvalidCompassStyle
        }
    }
}

struct TapeMarkerStyle {

    enum Justification {
        case Top
        case Bottom
        case Left
        case Right
    }
    
    let justification: Justification
    let pointsPerValue: UInt
    let majorMarkerLength: Int
    let minorMarkerLength: Int
    let majorMarkerFrequency: Int
    let minorMarkerFrequency: Int
    let textOffset: Int
    let color: SKColor
}
