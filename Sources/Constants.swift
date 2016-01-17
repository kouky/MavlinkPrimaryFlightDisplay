//
//  Constants.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 11/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct Constants {
    
    struct Font {
        static let family = "Helvetica-Bold"
        static let size: CGFloat = 16
    }
    
    struct Color {
        
        struct Horizon {
            static let sky = SKColor.blueColor()
            static let ground = SKColor.brownColor()
            static let zeroPitchLine = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        }
        
        struct PitchLadder {
            static let line = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        }
        
        struct BankIndicator {
            static let line = PitchLadder.line
            static let text = SKColor.whiteColor()
            static let skyPointer = SKColor.whiteColor()
        }
    }
    
    struct Size {
        
        struct PitchLadder {
            static let minorLineWidth = 20
            static let majorLineWidth = 60
        }        
        
        struct BankIndicator {
            static let radius = 160
            static let maximumDisplayDegree = 60 // Keep between 0 to 180
            static let lineWidth = 2
            static let minorMarkerHeight = 5
            static let majorMarkerHeight = 10
            static let markerTextOffset = 20
            static let skyPointerHeight = 12
            static let skyPointerWidth = 12
        }
    }
    
    struct Angular {
        
        static let degreesPerRadian: CGFloat = CGFloat(180.0 / M_PI)
        
        static let radiansPerDegree: CGFloat = CGFloat(M_PI / 180.0)
        
        static func pointsPerDegreeForSceneSize(size: CGSize) -> CGFloat {
            return (size.height / 2) / CGFloat(90)
        }
        
        static func pointsPerRadianForSceneSize(size: CGSize) -> CGFloat {
            return CGFloat(degreesPerRadian) * pointsPerDegreeForSceneSize(size)
        }
        
        static func radiansFromDegrees(degrees: CGFloat) -> CGFloat {
            return radiansPerDegree * degrees
        }
        
        static func degreesFromRadians(radians: CGFloat) -> CGFloat {
            return degreesPerRadian * radians
        }
    }
}
