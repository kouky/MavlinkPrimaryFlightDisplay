//
//  MenuManager.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 26/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import Cocoa
import ReactiveCocoa
import ORSSerial

class MenuManager: NSObject {
    
    let mavlinkMenu: NSMenu

    init(mavlinkMenu: NSMenu, availableSerialPorts: SignalProducer<[ORSSerialPort], NoError>) {
        self.mavlinkMenu = mavlinkMenu
        super.init()
        availableSerialPorts.startWithNext { [weak self] ports in
            print(ports)
            self?.updateMenu(ports)
        }
    }
    
    private func updateMenu(ports: [ORSSerialPort]) {
        mavlinkMenu.removeAllItems()
        for port in ports {
            let item = NSMenuItem(title: port.description, action:"command:", keyEquivalent: "")
            item.target = self
            mavlinkMenu.addItem(item)
        }
    }
    
    func command(sender: AnyObject) {
        if let menuItem = sender as? NSMenuItem {
            menuItem.state = 1
        }
    }
}
