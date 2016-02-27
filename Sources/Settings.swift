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



