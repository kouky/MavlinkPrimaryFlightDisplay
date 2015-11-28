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
    @IBOutlet weak var flightView: PrimaryFlightDisplayView!
    @IBOutlet weak var mavlinkMenu: NSMenu!
    var menuManager: MenuManager!
    var mavlinkController: MavlinkController!
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        mavlinkController = MavlinkController()
        menuManager = MenuManager(mavlinkMenu: mavlinkMenu, availableSerialPorts: mavlinkController.availableSerialPorts, mavlinkController: mavlinkController)
        
        mavlinkController.reactiveMavlink.heartbeat.observeNext { heartbeat in
            print(heartbeat)
        }
        
        mavlinkController.reactiveMavlink.attitude.observeNext { [weak self] attitude in
            self?.flightView.updateAttitude(attitude.roll)
        }

    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
