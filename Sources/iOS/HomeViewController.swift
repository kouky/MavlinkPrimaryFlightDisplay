//
//  HomeViewController.swift
//  MavlinkPrimaryFlightDisplay-iOS
//
//  Created by Michael Koukoullis on 26/03/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import UIKit
import ReactiveMavlink
import PrimaryFlightDisplay
import CoreBluetooth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scanButton: UIButton!
    
    let ble = BLE()
    let reactiveMavlink = ReactiveMavlink()
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        let flightView = PrimaryFlightDisplayView(frame: containerView.frame)
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
}

extension HomeViewController: BLEDelegate {
    
    func bleDidUpdateState(state: CBCentralManagerState) {
        switch state {
        case .PoweredOff: break
        case .PoweredOn:
            ble.startScanning(200)
            break
        case .Resetting: break
        case .Unauthorized: break
        case .Unknown: break
        case .Unsupported: break
        }
    }
    
    func bleDidDiscoverPeripherals() {
        if let peripheral = ble.peripherals.first {
            ble.connectToPeripheral(peripheral)
        }
    }
    
    func bleDidConnectToPeripheral() {
    }
    
    func bleDidReceiveData(data: NSData?) {
        if let data = data {
            reactiveMavlink.receiveData(data)
        }
    }
    
    func bleDidDisconenctFromPeripheral() {
    }
    
    func bleDidDicoverCharacateristics() {
        ble.setBaudRate()
    }
}
