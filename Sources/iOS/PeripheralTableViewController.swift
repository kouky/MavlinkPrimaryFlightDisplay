//
//  PeripheralTableViewController.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 31/03/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result
import CoreBluetooth

class PeripheralTableViewController: UITableViewController {
    
    private var peripherals = [CBPeripheral]()
    private let peripheralsProducer: SignalProducer<[CBPeripheral], NoError>
    private let bleScanner: BLEScanner
    private let bleConnector: BLEConnector
    
    init(producer: SignalProducer<[CBPeripheral], NoError>, scanner: BLEScanner, connector: BLEConnector) {
        peripheralsProducer = producer
        bleScanner = scanner
        bleConnector = connector
        super.init(style: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table view data source
    
    override func viewDidLoad() {
        self.tableView.registerClass(PeripheralTableViewCell.self, forCellReuseIdentifier: "peripheral")
        
        peripheralsProducer.start { [weak self] event in
            guard let `self` = self else { return }
            switch event {
            case .Next(let peripherals):
                self.peripherals = peripherals
                self.tableView.reloadData()
            default:
                return
            }
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("peripheral", forIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let peripheral = peripherals[indexPath.row]
        cell.textLabel?.text = "BLE Mini"
        cell.detailTextLabel?.text = "UUID: \(peripheral.identifier.UUIDString)"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        bleConnector(peripheralForIndexPath(indexPath))
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func peripheralForIndexPath(indexPath: NSIndexPath) -> CBPeripheral {
        return peripherals[indexPath.row]
    }
}
