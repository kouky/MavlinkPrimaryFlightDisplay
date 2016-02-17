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
    let markerStyle: TapeMarkerStyle
    
    var optimalCellMagnitude: Int {
        switch markerStyle.justification {
        case .Bottom, .Top:
            return Int(round(size.width / CGFloat(markerStyle.pointsPerValue)))
        case .Left, .Right:
            return Int(round(size.height / CGFloat(markerStyle.pointsPerValue)))
        }
    }
    
    var seedModel: TapeCellModelType {
        do {
            switch type {
            case .Continuous:
                return try ContinuousTapeCellModel(lowerValue: 0, upperValue: optimalCellMagnitude)
            case .Compass:
                return try CompassTapeCellModel(lowerValue: 0, upperValue: optimalCellMagnitude)
            }
        } catch {
            fatalError("Could not create seed tape cell model")
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
    
    enum Type {
        case Compass
        case Continuous
        
        func labelForValue(value: Int) -> String  {
            switch self {
            case .Continuous:
                return "\(value)"
            case .Compass:
                var presentedValue = value % 360
                if presentedValue < 0 {
                    presentedValue = 360 + presentedValue
                }
                
                let cardinalDirections = [0: "N", 45: "NE", 90: "E", 135: "SE", 180: "S", 225: "SW", 270: "W", 315: "NW"]
                if let cardinal = cardinalDirections[presentedValue] {
                    return cardinal
                } else {
                    return "\(presentedValue)"
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
