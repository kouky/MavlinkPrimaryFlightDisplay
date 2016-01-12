//
//  Constants.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 11/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct Constants {
    
    struct Color {
        
        struct Horizon {
            static let sky = SKColor.blueColor()
            static let ground = SKColor.brownColor()
        }
    }
    
    struct Size {
        
        struct PitchLadder {
            static let minorLineWidth = 20
            static let majorLineWidth = 60
        }
        
        struct Degree {
            static let points = 5
        }
    }
    
    struct Angular {
        
        static let pointsPerDegree = 5
        static var pointsPerRadian : Double {
            return 57.296 * Double(pointsPerDegree)
        }
    }
}
