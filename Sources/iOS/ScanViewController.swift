//
//  ScanViewController.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 31/03/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa
import Result
import CoreBluetooth


class ScanViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    private let peripheralProducer: SignalProducer<[CBPeripheral], NoError>
    private let bleScanner: BLEScanner
    private let bleConnector: BLEConnector
    
    init(producer: SignalProducer<[CBPeripheral], NoError>, scanner: BLEScanner, connector: BLEConnector) {
        peripheralProducer = producer
        bleScanner = scanner
        bleConnector = connector
        super.init(nibName: "ScanViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "BLE Mini Peripheral"
        
        let list = PeripheralTableViewController(producer: peripheralProducer, scanner: bleScanner, connector: bleConnector)
        
        addChildViewController(list)
        contentView.addSubview(list.view)
        list.didMoveToParentViewController(self)
        
        list.view.snp_makeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
        
        bleScanner()
    }
    
    @IBAction func closeButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
