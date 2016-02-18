//
//  MavlinkController.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 22/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import Cocoa
import ORSSerial
import ReactiveMavlink
import ReactiveCocoa
import Result

class MavlinkController: NSObject {
    
    // MARK: Properties
    
    let reactiveMavlink = ReactiveMavlink()
    
    var serialPort: ORSSerialPort? {
        didSet {
            oldValue?.close()
            oldValue?.delegate = nil
            if let port = serialPort {
                port.delegate = self
                port.baudRate = 57600
                port.numberOfStopBits = 1
                port.parity = .None
                port.open()
                startUsbMavlinkSession()
            }
        }
    }
    
    var availableSerialPorts: SignalProducer<[ORSSerialPort], NoError>{
        return availablePorts.producer
    }
    
    private let availablePorts = MutableProperty<[ORSSerialPort]>([])
    private let serialPortManager = ORSSerialPortManager.sharedSerialPortManager()

    
    // MARK: Initializers
    
    override init() {
        super.init()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "serialPortsWereConnected:", name: ORSSerialPortsWereConnectedNotification, object: nil)
        notificationCenter.addObserver(self, selector: "serialPortsWereDisconnected:", name: ORSSerialPortsWereDisconnectedNotification, object: nil)
        NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self
        availablePorts.value = serialPortManager.availablePorts
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Actions
    
    
    private func startUsbMavlinkSession() {
        guard let port = serialPort where port.open else {
            print("Serial port is not open")
            return
        }
        
        guard let data = "mavlink start -d /dev/ttyACM0\n".dataUsingEncoding(NSUTF32LittleEndianStringEncoding) else {
            print("Cannot create mavlink USB start command")
            return
        }
        
        port.sendData(data)
    }
    
    // MARK: - Notifications
    
    func serialPortsWereConnected(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let connectedPorts = userInfo[ORSConnectedSerialPortsKey] as! [ORSSerialPort]
            print("Ports were connected: \(connectedPorts)")
            self.postUserNotificationForConnectedPorts(connectedPorts)
        }
        availablePorts.value = serialPortManager.availablePorts
    }
    
    func serialPortsWereDisconnected(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let disconnectedPorts: [ORSSerialPort] = userInfo[ORSDisconnectedSerialPortsKey] as! [ORSSerialPort]
            print("Ports were disconnected: \(disconnectedPorts)")
            self.postUserNotificationForDisconnectedPorts(disconnectedPorts)
        }
        availablePorts.value = serialPortManager.availablePorts
    }
    
    private func postUserNotificationForConnectedPorts(connectedPorts: [ORSSerialPort]) {
        let unc = NSUserNotificationCenter.defaultUserNotificationCenter()
        for port in connectedPorts {
            let userNote = NSUserNotification()
            userNote.title = NSLocalizedString("Serial Port Connected", comment: "Serial Port Connected")
            userNote.informativeText = "Serial Port \(port.name) was connected to your Mac."
            userNote.soundName = nil;
            unc.deliverNotification(userNote)
        }
    }
    
    private func postUserNotificationForDisconnectedPorts(disconnectedPorts: [ORSSerialPort]) {
        let unc = NSUserNotificationCenter.defaultUserNotificationCenter()
        for port in disconnectedPorts {
            let userNote = NSUserNotification()
            userNote.title = NSLocalizedString("Serial Port Disconnected", comment: "Serial Port Disconnected")
            userNote.informativeText = "Serial Port \(port.name) was disconnected from your Mac."
            userNote.soundName = nil;
            unc.deliverNotification(userNote)
        }
    }
}

extension MavlinkController: ORSSerialPortDelegate {
    
    func serialPortWasOpened(serialPort: ORSSerialPort) {
    }
    
    func serialPortWasClosed(serialPort: ORSSerialPort) {
    }
    
    func serialPortWasRemovedFromSystem(serialPort: ORSSerialPort) {
        self.serialPort = nil
    }
    
    func serialPort(serialPort: ORSSerialPort, didReceiveData data: NSData) {
        reactiveMavlink.receiveData(data)
    }
    
    func serialPort(serialPort: ORSSerialPort, didEncounterError error: NSError) {
        print("SerialPort \(serialPort.name) encountered an error: \(error)")
    }
}


extension MavlinkController: NSUserNotificationCenterDelegate {
    
    func userNotificationCenter(center: NSUserNotificationCenter, didDeliverNotification notification: NSUserNotification) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue()) {
            center.removeDeliveredNotification(notification)
        }
    }
    
    func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
        return true
    }
}
