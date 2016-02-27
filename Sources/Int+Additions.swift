//
//  Int+Additions.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 27/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import Foundation

extension Int {
    
    var radians: CGFloat {
        return CGFloat.radiansPerDegree * CGFloat(self)
    }
}
