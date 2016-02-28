//
//  Settings.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 27/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

public protocol SettingsType {
    var horizon:                HorizonStyleType { get }
    var attitudeReferenceIndex: AttitudeReferenceIndexStyleType { get }
    var pitchLadder:            PitchLadderStyleType { get }
    var bankIndicator:          BankIndicatorStyleType { get }
    var altimeter:              TapeIndicatorStyleType { get }
    var airSpeedIndicator:      TapeIndicatorStyleType { get }
    var headingIndicator:       TapeIndicatorStyleType { get }
}

public struct DefaultSettings: SettingsType {
    public let horizon: HorizonStyleType = DefaultHorizonStyle()
    public let attitudeReferenceIndex: AttitudeReferenceIndexStyleType = DefaultAttitudeReferenceIndexStyle()
    public let pitchLadder: PitchLadderStyleType = DefaultPitchLadderStyle()
    public let bankIndicator: BankIndicatorStyleType = DefaultBankIndicatorStyle()
    public let altimeter: TapeIndicatorStyleType = DefaultAltimeterStyle()
    public let airSpeedIndicator: TapeIndicatorStyleType = DefaultAirspeedIndicatorStyle()
    public let headingIndicator: TapeIndicatorStyleType = DefaultHeadingIndicatorStyle()
}

// MARK: HorizonStyle

public protocol HorizonStyleType {
    var skyColor:           SKColor { get set }
    var groundColor:        SKColor { get set }
    var zeroPitchLineColor: SKColor { get set }
}

public struct DefaultHorizonStyle: HorizonStyleType {
    public var skyColor = SKColor(red: 0.078, green: 0.490, blue: 0.816, alpha: 1.00)
    public var groundColor = SKColor(red: 0.667, green: 0.855, blue: 0.196, alpha: 1.00)
    public var zeroPitchLineColor = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
}

// MARK: AttitudeReferenceIndexStyle

public protocol AttitudeReferenceIndexStyleType {
    var fillColor:      SKColor { get set }
    var strokeColor:    SKColor { get set }
    var centerBarWidth: Int { get set }
    var sideBarHeight:  Int { get set }
    var sideBarWidth:   Int { get set }
    var sideBarOffset:  Int { get set }
}

public struct DefaultAttitudeReferenceIndexStyle: AttitudeReferenceIndexStyleType {
    public var fillColor = SKColor.whiteColor()
    public var strokeColor = SKColor.blackColor()
    public var centerBarWidth = 10
    public var sideBarWidth = 120
    public var sideBarHeight = 20
    public var sideBarOffset = 70
}

// MARK: PitchLadder

public protocol PitchLadderStyleType {
    var fillColor:      SKColor  { get set }
    var strokeColor:    SKColor  { get set }
    var textColor:      SKColor  { get set }
    var font:           FontType { get set }
    var minorLineWidth:     Int { get set }
    var majorLineWidth:     Int { get set }
    var markerTextOffset:   Int { get set }
}

public struct DefaultPitchLadderStyle: PitchLadderStyleType {
    public var fillColor = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    public var strokeColor = SKColor.blackColor()
    public var textColor = SKColor.whiteColor()
    public var font: FontType = DefaultFont()
    public var minorLineWidth = 20
    public var majorLineWidth = 50
    public var markerTextOffset = 10
}

// MARK: BankIndicator

public protocol BankIndicatorStyleType {
    var arcStrokeColor:       SKColor  { get set }
    var textColor:            SKColor  { get set }
    var font:                 FontType { get set }
    var skyPointerFillColor:  SKColor  { get set }
    
    var arcRadius:               Int { get set }
    var arcMaximumDisplayDegree: Int { get set } // Keep between 0 and 180
    var arcLineWidth:         Int { get set }
    var minorMarkerHeight:    Int { get set }
    var majorMarkerHeight:    Int { get set }
    var markerTextOffset:     Int { get set }
    var skyPointerHeight:     Int { get set }
    var skyPointerWidth:      Int { get set }
}

public struct DefaultBankIndicatorStyle: BankIndicatorStyleType {
    public var arcStrokeColor = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    public var textColor = SKColor.whiteColor()
    public var font: FontType = DefaultFont()
    public var skyPointerFillColor = SKColor.whiteColor()
    
    public var arcRadius = 180
    public var arcMaximumDisplayDegree = 60
    public var arcLineWidth = 2
    public var minorMarkerHeight = 5
    public var majorMarkerHeight = 10
    public var markerTextOffset = 20
    public var skyPointerHeight = 12
    public var skyPointerWidth = 12
}

// MARK: TapeIndicator

public enum TapeType {
    case Compass
    case Continuous
}

public enum TapeMarkerJustification {
    case Top
    case Bottom
    case Left
    case Right
}

public protocol TapeIndicatorStyleType {
    var size:                   CGSize { get set }
    var type:                   TapeType { get set }
    var backgroundColor:        SKColor { get set }
    var pointerBackgroundColor: SKColor { get set }
    var font:                   FontType { get set }

    var markerJustification:    TapeMarkerJustification { get set }
    var pointsPerUnitValue:     UInt { get set }
    var majorMarkerLength:      Int { get set }
    var minorMarkerLength:      Int { get set }
    var majorMarkerFrequency:   Int { get set }
    var minorMarkerFrequency:   Int { get set }
    var markerTextOffset:       Int { get set }
    var markerColor:            SKColor { get set }
    var markerTextColor:        SKColor { get set }    
}

public struct DefaultAltimeterStyle: TapeIndicatorStyleType {
    public var size = CGSize(width: 60, height: 300)
    public var type = TapeType.Continuous
    public var backgroundColor = SKColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.5)
    public var pointerBackgroundColor = SKColor.blackColor()
    public var font: FontType = DefaultFont()

    public var markerJustification = TapeMarkerJustification.Left
    public var pointsPerUnitValue: UInt = 15
    public var majorMarkerLength = 10
    public var minorMarkerLength = 5
    public var majorMarkerFrequency = 5
    public var minorMarkerFrequency = 1
    public var markerTextOffset = 20
    public var markerColor = SKColor.whiteColor()
    public var markerTextColor = SKColor.whiteColor()
}

public struct DefaultAirspeedIndicatorStyle: TapeIndicatorStyleType {
    public var size = CGSize(width: 60, height: 300)
    public var type = TapeType.Continuous
    public var backgroundColor = SKColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.5)
    public var pointerBackgroundColor = SKColor.blackColor()
    public var font: FontType = DefaultFont()
    
    public var markerJustification = TapeMarkerJustification.Right
    public var pointsPerUnitValue: UInt = 5
    public var majorMarkerLength = 10
    public var minorMarkerLength = 5
    public var majorMarkerFrequency = 10
    public var minorMarkerFrequency = 5
    public var markerTextOffset = 20
    public var markerColor = SKColor.whiteColor()
    public var markerTextColor = SKColor.whiteColor()
}

public struct DefaultHeadingIndicatorStyle: TapeIndicatorStyleType {
    public var size = CGSize(width: 400, height: 60)
    public var type = TapeType.Compass
    public var backgroundColor = SKColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.5)
    public var pointerBackgroundColor = SKColor.blackColor()
    public var font: FontType = DefaultFont()
    
    public var markerJustification = TapeMarkerJustification.Bottom
    public var pointsPerUnitValue: UInt = 5
    public var majorMarkerLength = 10
    public var minorMarkerLength = 5
    public var majorMarkerFrequency = 10
    public var minorMarkerFrequency = 5
    public var markerTextOffset = 22
    public var markerColor = SKColor.whiteColor()
    public var markerTextColor = SKColor.whiteColor()
}

extension TapeIndicatorStyleType {
    public func labelForValue(value: Int) -> String  {
        switch type {
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
    
    public var seedModel: TapeCellModelType {
        switch type {
        case .Continuous:
            return ContinuousTapeCellModel(lowerValue: 0, upperValue: optimalCellMagnitude)
        case .Compass:
            return CompassTapeCellModel(lowerValue: 0, upperValue: optimalCellMagnitude)
        }
    }

    public var optimalCellMagnitude: Int {
        switch type {
        case .Continuous:
            switch markerJustification {
            case .Bottom, .Top:
                return Int(round(size.width / CGFloat(pointsPerUnitValue)))
            case .Left, .Right:
                return Int(round(size.height / CGFloat(pointsPerUnitValue)))
            }
        case .Compass:
            return 120
        }
    }    
}

// MARK: Font

public protocol FontType {
    var family: String { get }
    var size:   CGFloat { get }
}

public struct DefaultFont: FontType {
    public var family = "Helvetica-Bold"
    public var size: CGFloat = 16
}
