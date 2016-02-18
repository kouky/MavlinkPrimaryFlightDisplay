//
//  MenuManager.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 26/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import Cocoa
import ReactiveCocoa
import Result
import ORSSerial

private typealias MenuPort = (port: ORSSerialPort, menuItem: NSMenuItem)

class MenuManager: NSObject {
    
    private let mavlinkMenu: NSMenu
    private let mavlinkController: MavlinkController

    init(mavlinkMenu: NSMenu, availableSerialPorts: SignalProducer<[ORSSerialPort], NoError>, mavlinkController: MavlinkController) {
        self.mavlinkMenu = mavlinkMenu
        self.mavlinkController = mavlinkController
        super.init()
        
        let ports = availableSerialPorts.map { ports -> [MenuPort] in
            return ports.map { port in
                let item = NSMenuItem(title: port.description, action:"connectPort:", keyEquivalent: "")
                return (port, item)
            }
        }   
        
        ports.startWithNext { [weak self] items in
            self?.mavlinkMenu.removeAllItems()
            for (port, menuItem) in items {
                menuItem.target = self
                menuItem.representedObject = port
                self?.mavlinkMenu.addItem(menuItem)
            }
            self?.mavlinkMenu.addItem(NSMenuItem.separatorItem())

            let disconnectItem = NSMenuItem(title: "Disconnect", action:"disconnectPort:", keyEquivalent: "")
            disconnectItem.target = self
            self?.mavlinkMenu.addItem(disconnectItem)
        }
    }
    
    func connectPort(sender: AnyObject) {
        mavlinkMenu.resetStateForMenuItems()
        
        if let menuItem = sender as? NSMenuItem, port = menuItem.representedObject as? ORSSerialPort {
            mavlinkController.serialPort = port
            menuItem.state = 1
        }
    }
    
    func disconnectPort(sender: AnyObject) {
        mavlinkController.serialPort = nil
        mavlinkMenu.resetStateForMenuItems()
    }
}

private extension NSMenu {
    func resetStateForMenuItems() {
        for menuItem in itemArray {
            menuItem.state = 0
        }
    }
}
