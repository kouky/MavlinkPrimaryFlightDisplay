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
}

public struct DefaultSettings: SettingsType {
    public let horizon: HorizonStyleType = DefaultHorizonStyle()
    public let attitudeReferenceIndex: AttitudeReferenceIndexStyleType = DefaultAttitudeReferenceIndexStyle()
    public let pitchLadder: PitchLadderStyleType = DefaultPitchLadderStyle()
    public let bankIndicator: BankIndicatorStyleType = DefaultBankIndicatorStyle()
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
    var fillColor:      SKColor { get set }
    var strokeColor:    SKColor { get set }
    var textColor:      SKColor { get set }
    var minorLineWidth:     Int { get set }
    var majorLineWidth:     Int { get set }
    var markerTextOffset:   Int { get set }
}

public struct DefaultPitchLadderStyle: PitchLadderStyleType {
    public var fillColor = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    public var strokeColor = SKColor.blackColor()
    public var textColor = SKColor.whiteColor()
    public var minorLineWidth = 20
    public var majorLineWidth = 50
    public var markerTextOffset = 10
}

// MARK: BankIndicator

public protocol BankIndicatorStyleType {
    var arcStrokeColor:          SKColor { get set }
    var textColor:            SKColor { get set }
    var skyPointerFillColor:  SKColor { get set }
    
    var arcRadius:               Int { get set }
    var arcMaximumDisplayDegree: Int { get set }
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
    public var skyPointerFillColor = SKColor.whiteColor()
    
    public var arcRadius = 180
    public var arcMaximumDisplayDegree = 60 // Keep between 0 to 180
    public var arcLineWidth = 2
    public var minorMarkerHeight = 5
    public var majorMarkerHeight = 10
    public var markerTextOffset = 20
    public var skyPointerHeight = 12
    public var skyPointerWidth = 12
}
