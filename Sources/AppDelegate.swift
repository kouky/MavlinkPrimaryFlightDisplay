//
//  AppDelegate.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 19/11/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var mavlinkMenu: NSMenu!
    var menuManager: MenuManager!
    var mavlinkController: MavlinkController!
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        
        let frame = (self.window.contentView?.frame)!
        let flightView = PrimaryFlightDisplayView(frame: frame)
        
        mavlinkController = MavlinkController()
        menuManager = MenuManager(mavlinkMenu: mavlinkMenu, availableSerialPorts: mavlinkController.availableSerialPorts, mavlinkController: mavlinkController)
                
        mavlinkController.reactiveMavlink.attitude.observeNext { attitude in
            let attitude = Attitude(pitchRadians: attitude.pitch, rollRadians: attitude.roll)
            flightView.setAttitude(attitude)
        }
        
        mavlinkController.reactiveMavlink.headUpDisplay.observeNext { hud in
            flightView.setHeading(Double(hud.heading))
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
