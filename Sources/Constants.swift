//
//  Constants.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 11/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

struct Constants {
    
    struct Style {
        
        static func altimeter() -> TapeStyle {
            do {
                return try TapeStyle(
                    size: CGSize(width: 60, height: 300),
                    type: .Continuous,
                    backgroundColor: SKColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.5),
                    pointerBackgroundColor: SKColor.blackColor(),
                    font: DefaultFont(),
                    markerStyle: TapeMarkerStyle(
                        justification: .Left,
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
                    font: DefaultFont(),
                    markerStyle: TapeMarkerStyle(
                        justification: .Right,
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
                    font: DefaultFont(),
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
