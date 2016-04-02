//
//  PeripheralTableViewController.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 31/03/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import UIKit

class PeripheralTableViewController: UITableViewController {

    // MARK: - Table view data source
    
    override func viewDidLoad() {
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "peripheral")
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peripheral", forIndexPath: indexPath)

        cell.textLabel?.text = "Test"

        return cell
    }
}
