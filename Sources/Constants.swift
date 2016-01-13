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
        
        struct PitchLadder {
            static let line = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
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
