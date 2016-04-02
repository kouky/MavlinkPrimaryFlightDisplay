//
//  ScanViewController.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 31/03/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import UIKit
import SnapKit

class ScanViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "BLE Mini Peripheral"
        
        let list = PeripheralTableViewController(style: .Plain)
        
        addChildViewController(list)
        contentView.addSubview(list.view)
        list.didMoveToParentViewController(self)
        
        list.view.snp_makeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
    }
    
    @IBAction func closeButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
