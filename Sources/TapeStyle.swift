//
//  TapeStyle.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 16/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct TapeStyle {
    
    let size: CGSize
    let type: Type
    let backgroundColor: SKColor
    let pointerBackgroundColor: SKColor
    let font: FontType
    let markerStyle: TapeMarkerStyle
    
    private var optimalCellMagnitude: Int {
        switch type {
        case .Continuous:
            switch markerStyle.justification {
            case .Bottom, .Top:
                return Int(round(size.width / CGFloat(markerStyle.pointsPerValue)))
            case .Left, .Right:
                return Int(round(size.height / CGFloat(markerStyle.pointsPerValue)))
            }
        case .Compass:
            return 120
        }
    }
    
    var seedModel: TapeCellModelType {
        switch type {
        case .Continuous:
            return ContinuousTapeCellModel(lowerValue: 0, upperValue: optimalCellMagnitude)
        case .Compass:
            return CompassTapeCellModel(lowerValue: 0, upperValue: optimalCellMagnitude)
        }
    }

    init(size: CGSize, type: Type, backgroundColor: SKColor, pointerBackgroundColor: SKColor, font: FontType, markerStyle: TapeMarkerStyle) throws {
        self.size = size
        self.type = type
        self.backgroundColor = backgroundColor
        self.pointerBackgroundColor = pointerBackgroundColor
        self.font = font
        self.markerStyle = markerStyle

        switch markerStyle.justification {
        case .Bottom, .Top:
            if type == .Compass && (size.width / CGFloat(markerStyle.pointsPerValue) > CGFloat(optimalCellMagnitude)) {
                throw Error.InvalidCompassStyle
            }
        case .Left, .Right:
            if type == .Compass && (size.height / CGFloat(markerStyle.pointsPerValue) > CGFloat(optimalCellMagnitude)) {
                throw Error.InvalidCompassStyle
            }
        }
    }
    
    enum Type {
        case Compass
        case Continuous
        
        func labelForValue(value: Int) -> String  {
            switch self {
            case .Continuous:
                return "\(value)"
            case .Compass:
                let compassValue = Int(value.compassValue)
                let cardinalDirections = [0: "N", 45: "NE", 90: "E", 135: "SE", 180: "S", 225: "SW", 270: "W", 315: "NW"]
                
                if let cardinal = cardinalDirections[compassValue] {
                    return cardinal
                } else {
                    return "\(compassValue)"
                }
            }
        }
    }
    
    enum Error: ErrorType {
        case InvalidCompassStyle
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
