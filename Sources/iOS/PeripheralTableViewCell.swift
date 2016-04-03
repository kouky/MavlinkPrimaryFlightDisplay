//
//  PeripheralTableViewCell.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 2/04/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import UIKit

class PeripheralTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
