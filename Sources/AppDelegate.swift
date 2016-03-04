//
//  AppDelegate.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 19/11/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//

import Cocoa
import SpriteKit
import PrimaryFlightDisplay

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var mavlinkMenu: NSMenu!
    var menuManager: MenuManager!
    var mavlinkController: MavlinkController!
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        
        let frame = (self.window.contentView?.frame)!
        var settings = DefaultSettings()
        
        // Customise the settings
//        let pinkColor = SKColor(red:1.00, green:0.11, blue:0.56, alpha:1.0)
//        settings.horizon.groundColor = SKColor.brownColor()
//        
//        settings.bankIndicator.skyPointerFillColor = pinkColor
//        settings.bankIndicator.arcMaximumDisplayDegree = 75
//        settings.bankIndicator.arcRadius = 160
//        
//        settings.attitudeReferenceIndex.fillColor = pinkColor
//        settings.attitudeReferenceIndex.sideBarWidth = 80
//        settings.attitudeReferenceIndex.sideBarHeight = 15
//
//        settings.headingIndicator.pointsPerUnitValue = 8
//        settings.headingIndicator.size.width = 800
//        settings.headingIndicator.size.height = 40
//        settings.headingIndicator.markerTextOffset = 15
//        settings.headingIndicator.minorMarkerFrequency = 1
//        settings.headingIndicator.majorMarkerFrequency = 10
        
        let flightView = PrimaryFlightDisplayView(frame: frame, settings: settings)
        
        mavlinkController = MavlinkController()
        menuManager = MenuManager(mavlinkMenu: mavlinkMenu, availableSerialPorts: mavlinkController.availableSerialPorts, mavlinkController: mavlinkController)
                
        mavlinkController.reactiveMavlink.attitude.observeNext { attitude in
            flightView.setAttitude(rollRadians: Double(attitude.roll), pitchRadians: Double(attitude.pitch))
        }
        
        mavlinkController.reactiveMavlink.headUpDisplay.observeNext { hud in
            flightView.setHeadingDegree(Double(hud.heading))
            flightView.setAirSpeed(Double(hud.airSpeed))
            flightView.setAltitude(Double(hud.altitude))
        }
        
        flightView.autoresizingMask = [.ViewHeightSizable, .ViewWidthSizable]
        self.window.contentView?.addSubview(flightView)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
