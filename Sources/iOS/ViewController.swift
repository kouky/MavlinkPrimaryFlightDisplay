//
//  ViewController.swift
//  MavlinkPrimaryFlightDisplay-iOS
//
//  Created by Michael Koukoullis on 26/03/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import UIKit
import PrimaryFlightDisplay

class ViewController: UIViewController {
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        let flightView = PrimaryFlightDisplayView(frame: view.frame)
        flightView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        view.addSubview(flightView)
    }
}
