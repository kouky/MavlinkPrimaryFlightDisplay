//
//  HomeViewController.swift
//  MavlinkPrimaryFlightDisplay-iOS
//
//  Created by Michael Koukoullis on 26/03/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import UIKit
import ReactiveMavlink
import ReactiveCocoa
import PrimaryFlightDisplay
import CoreBluetooth
import SpriteKit

typealias BLEScanner = () -> ()
typealias BLEConnector = CBPeripheral -> ()

class HomeViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scanButton: UIButton!
    
    private let ble = BLE()
    private let reactiveMavlink = ReactiveMavlink()
    private let peripherals = MutableProperty([CBPeripheral]())
    
    private var bleScanner: BLEScanner {
        return { [weak self] in
            guard let `self` = self else { return }
            if case .PoweredOn = self.ble.state {
                self.ble.startScanning(10)
            }
        }
    }
    
    private var bleConnector: BLEConnector {
        return { [weak self] peripheral in
            guard let `self` = self else { return }
            if case .PoweredOn = self.ble.state {
                self.ble.connectToPeripheral(peripheral)
            }
        }
    }
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        
        var settings = iPadSettings()
        if case .Phone = UIDevice.currentDevice().userInterfaceIdiom {
            settings = iPhoneSettings()
        }
        
        let flightView = PrimaryFlightDisplayView(frame: containerView.frame, settings: settings)
        flightView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        containerView.addSubview(flightView)
        ble.delegate = self
        
        scanButton.layer.cornerRadius = 4
        
        reactiveMavlink.headUpDisplay.observeNext { [weak flightView] hud in
            flightView?.setHeadingDegree(Double(hud.heading))
            flightView?.setAirSpeed(Double(hud.airSpeed))
            flightView?.setAltitude(Double(hud.altitude))
        }
        
        reactiveMavlink.attitude.observeNext { [weak flightView] attitude in
            flightView?.setAttitude(rollRadians: Double(attitude.roll), pitchRadians: Double(attitude.pitch))
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [.Landscape]
    }
    
    @IBAction func scanButtonTapped(sender: UIButton) {
        let scanViewController = ScanViewController(producer: peripherals.producer, scanner: bleScanner, connector: bleConnector)
        let navViewConroller  = UINavigationController(rootViewController: scanViewController)
        presentViewController(navViewConroller, animated: true, completion: nil)
    }
}

extension HomeViewController: BLEDelegate {
    
    func bleDidDiscoverPeripherals() {
        self.peripherals.value = ble.peripherals
    }
    
    func bleDidConnectToPeripheral() {
        // Noop
    }
    
    func bleDidReceiveData(data: NSData?) {
        if let data = data {
            reactiveMavlink.receiveData(data)
        }
    }
    
    func bleDidDisconenctFromPeripheral() {
        // Noop
    }
    
    func bleDidDicoverCharacateristics() {
        ble.setBaudRate(.Bps57600)
    }
}

private func iPhoneSettings() -> SettingsType {
    var settings = DefaultSmallScreenSettings()
    let pinkColor = SKColor(red:1.00, green:0.11, blue:0.56, alpha:1.0)
    settings.horizon.groundColor = SKColor.brownColor()
    settings.attitudeReferenceIndex.fillColor = pinkColor
    settings.bankIndicator.skyPointerFillColor = pinkColor
    settings.bankIndicator.arcMaximumDisplayDegree = 75
    return settings
}

private func iPadSettings() -> SettingsType {
    var settings = DefaultSettings()
    let pinkColor = SKColor(red:1.00, green:0.11, blue:0.56, alpha:1.0)
    settings.horizon.groundColor = SKColor.brownColor()

    settings.bankIndicator.skyPointerFillColor = pinkColor
    settings.bankIndicator.arcMaximumDisplayDegree = 75
    settings.bankIndicator.arcRadius = 160

    settings.attitudeReferenceIndex.fillColor = pinkColor
    settings.attitudeReferenceIndex.sideBarWidth = 80
    settings.attitudeReferenceIndex.sideBarHeight = 15

    settings.headingIndicator.pointsPerUnitValue = 10
    settings.headingIndicator.size.width = 1060
    settings.headingIndicator.size.height = 40
    settings.headingIndicator.markerTextOffset = 15
    settings.headingIndicator.minorMarkerFrequency = 1
    settings.headingIndicator.majorMarkerFrequency = 10
    return settings
}
