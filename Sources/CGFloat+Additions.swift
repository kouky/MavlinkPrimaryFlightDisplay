//
//  CGFloat+Additions.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 27/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import Foundation

extension CGFloat {
    
    static var degreesPerRadian: CGFloat {
       return CGFloat(180.0 / M_PI)
    }
    
    static var radiansPerDegree: CGFloat {
       return CGFloat(M_PI / 180.0)
    }
}
