//
//  Settings.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 27/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

public struct Settings {
    let horizon: HorizonStyleType = DefaultHorizonStyle()
    let attitudeReferenceIndex: AttitudeReferenceIndexStyleType = DefaultAttitudeReferenceIndexStyle()
    let pitchLadder: PitchLadderStyleType = DefaultPitchLadderStyle()
    let bankIndicator: BankIndicatorStyleType = DefaultBankIndicatorStyle()
}

// MARK: HorizonStyle

protocol HorizonStyleType {
    var skyColor:           SKColor { get set }
    var groundColor:        SKColor { get set }
    var zeroPitchLineColor: SKColor { get set }
}

struct DefaultHorizonStyle: HorizonStyleType {
    var skyColor = SKColor(red: 0.078, green: 0.490, blue: 0.816, alpha: 1.00)
    var groundColor = SKColor(red: 0.667, green: 0.855, blue: 0.196, alpha: 1.00)
    var zeroPitchLineColor = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
}

// MARK: AttitudeReferenceIndexStyle

protocol AttitudeReferenceIndexStyleType {
    var fillColor:      SKColor { get set }
    var strokeColor:    SKColor { get set }
    var centerBarWidth: Int { get set }
    var sideBarHeight:  Int { get set }
    var sideBarWidth:   Int { get set }
    var sideBarOffset:  Int { get set }
}

struct DefaultAttitudeReferenceIndexStyle: AttitudeReferenceIndexStyleType {
    var fillColor = SKColor.whiteColor()
    var strokeColor = SKColor.blackColor()
    var centerBarWidth = 10
    var sideBarWidth = 120
    var sideBarHeight = 20
    var sideBarOffset = 70
}

// MARK: PitchLadder

protocol PitchLadderStyleType {
    var fillColor:      SKColor { get set }
    var strokeColor:    SKColor { get set }
    var textColor:      SKColor { get set }
    var minorLineWidth:     Int { get set }
    var majorLineWidth:     Int { get set }
    var markerTextOffset:   Int { get set }
}

struct DefaultPitchLadderStyle: PitchLadderStyleType {
    var fillColor = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    var strokeColor = SKColor.blackColor()
    var textColor = SKColor.whiteColor()
    var minorLineWidth = 20
    var majorLineWidth = 50
    var markerTextOffset = 10
}

// MARK: BankIndicator

protocol BankIndicatorStyleType {
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

struct DefaultBankIndicatorStyle: BankIndicatorStyleType {
    var arcStrokeColor = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    var textColor = SKColor.whiteColor()
    var skyPointerFillColor = SKColor.whiteColor()
    
    var arcRadius = 180
    var arcMaximumDisplayDegree = 60 // Keep between 0 to 180
    var arcLineWidth = 2
    var minorMarkerHeight = 5
    var majorMarkerHeight = 10
    var markerTextOffset = 20
    var skyPointerHeight = 12
    var skyPointerWidth = 12
}
