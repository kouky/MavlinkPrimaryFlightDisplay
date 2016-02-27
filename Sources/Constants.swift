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
        
        struct PitchLadder {
            static let line = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        }
        
        struct BankIndicator {
            static let line = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            static let text = SKColor.whiteColor()
            static let skyPointer = SKColor.whiteColor()
        }        
    }
    
    struct Size {
        
        struct PitchLadder {
            static let minorLineWidth = 20
            static let majorLineWidth = 50
            static let markerTextOffset = 10
        }
        
        struct BankIndicator {
            static let radius = 180
            static let maximumDisplayDegree = 60 // Keep between 0 to 180
            static let lineWidth = 2
            static let minorMarkerHeight = 5
            static let majorMarkerHeight = 10
            static let markerTextOffset = 20
            static let skyPointerHeight = 12
            static let skyPointerWidth = 12
        }
    }
    
    struct Style {
        
        static func altimeter() -> TapeStyle {
            do {
                return try TapeStyle(
                    size: CGSize(width: 60, height: 300),
                    type: .Continuous,
                    backgroundColor: SKColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.5),
                    pointerBackgroundColor: SKColor.blackColor(),
                    markerStyle: TapeMarkerStyle(
                        justification: .Right,
                        pointsPerValue: 15,
                        majorMarkerLength: 10,
                        minorMarkerLength: 5,
                        majorMarkerFrequency: 5,
                        minorMarkerFrequency: 1,
                        textOffset: 20,
                        color: SKColor.whiteColor()
                    )
                )
            } catch {
                fatalError("Invalid compass style. Decrease size and/or increase points per value.")
            }
        }
        
        static func airSpeedIndicator() -> TapeStyle {
            do {
                return try TapeStyle(
                    size: CGSize(width: 60, height: 300),
                    type: .Continuous,
                    backgroundColor: SKColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.5),
                    pointerBackgroundColor: SKColor.blackColor(),
                    markerStyle: TapeMarkerStyle(
                        justification: .Left,
                        pointsPerValue: 5,
                        majorMarkerLength: 10,
                        minorMarkerLength: 5,
                        majorMarkerFrequency: 10,
                        minorMarkerFrequency: 5,
                        textOffset: 20,
                        color: SKColor.whiteColor()
                    )
                )
            } catch {
                fatalError("Invalid compass style. Decrease size and/or increase points per value.")
            }
        }
        
        static func headingIndicator() -> TapeStyle {
            do {
                return try TapeStyle(
                    size: CGSize(width: 400, height: 60),
                    type: .Compass,
                    backgroundColor: SKColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.5),
                    pointerBackgroundColor: SKColor.blackColor(),
                    markerStyle: TapeMarkerStyle(
                        justification: .Bottom,
                        pointsPerValue: 5,
                        majorMarkerLength: 10,
                        minorMarkerLength: 5,
                        majorMarkerFrequency: 10,
                        minorMarkerFrequency: 5,
                        textOffset: 22,
                        color: SKColor.whiteColor()
                    )
                )
            } catch {
                fatalError("Invalid compass style. Decrease size and/or increase points per value.")
            }
        }
    }    
}
