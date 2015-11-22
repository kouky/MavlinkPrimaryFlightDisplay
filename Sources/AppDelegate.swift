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
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let scene = PrimaryFlightDisplayScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        skView.presentScene(scene)
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        self.skView.showsFPS = true
        self.skView.showsNodeCount = true
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
