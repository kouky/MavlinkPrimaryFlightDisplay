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
        ble.setBaudRate()
    }
}
