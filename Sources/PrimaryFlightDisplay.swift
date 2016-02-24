//
//  PrimaryFlightDisplayScene.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 21/11/2015.
//  Copyright © 2015 Michael Koukoullis. All rights reserved.
//

import SpriteKit
import Darwin

public class PrimaryFlightDisplayView: SKView {
    
    // MARK: Initializers
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let scene = PrimaryFlightDisplayScene(size: bounds.size)
        scene.scaleMode = .AspectFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        presentScene(scene)
        
        // Apply additional optimizations to improve rendering performance
        ignoresSiblingOrder = true
        
        // Diagnostics
        showsFPS = true
        showsNodeCount = true
    }
    
    public func setHeading(heading: Double) {
        if let scene = scene as? PrimaryFlightDisplayScene {
            scene.setHeading(heading)
        }
    }
    
    public func setAirSpeed(airSpeed: Double) {
        if let scene = scene as? PrimaryFlightDisplayScene {
            scene.setAirSpeed(airSpeed)
        }
    }

    public func setAltitude(altitude: Double) {
        if let scene = scene as? PrimaryFlightDisplayScene {
            scene.setAltitude(altitude)
        }
    }
}

extension PrimaryFlightDisplayView: AttitudeSettable {
    func setAttitude(attitude: AttitudeType) {
        if let scene = scene as? PrimaryFlightDisplayScene {
            scene.setAttitude(attitude)
        }
    }
}

class PrimaryFlightDisplayScene: SKScene {
    
    private let horizon: Horizon
    private let pitchLadder: PitchLadder
    private let attitudeReferenceIndex = AttitudeReferenceIndex()
    private let bankIndicator = BankIndicator()
    private let altimeter = TapeIndicator(style: Constants.Style.altimeter())
    private let airSpeedIndicator = TapeIndicator(style: Constants.Style.airSpeedIndicator())
    private let headingIndicator = TapeIndicator(style: Constants.Style.headingIndicator())

    override init(size: CGSize) {
        horizon = Horizon(sceneSize: size)
        pitchLadder = PitchLadder(sceneSize: size)
        super.init(size: size)
        
        delayOnMainQueue(1) { self.altimeter.value = 20 }
        delayOnMainQueue(3) { self.altimeter.value = 40 }
        delayOnMainQueue(5) { self.altimeter.value = 60 }
        delayOnMainQueue(7) { self.altimeter.value = 100 }
        delayOnMainQueue(9) { self.altimeter.value = 140 }
        delayOnMainQueue(12) { self.altimeter.value = 0 }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToView(view: SKView) {
        scaleMode = .ResizeFill
        addChild(horizon)
        addChild(pitchLadder)
        addChild(attitudeReferenceIndex)
        addChild(bankIndicator)
        addChild(altimeter)
        addChild(airSpeedIndicator)
        addChild(headingIndicator)
    }
    
    override func didChangeSize(oldSize: CGSize) {
        altimeter.position = CGPoint(x: -size.width/2 + altimeter.style.size.width/2, y: 0)
        airSpeedIndicator.position = CGPoint(x: size.width/2 - airSpeedIndicator.style.size.width/2, y: 0)
        headingIndicator.position = CGPoint(x: 0, y: size.height/2 - headingIndicator.style.size.height/2)
    }
    
    override func didEvaluateActions() {
        altimeter.recycleCells()
        airSpeedIndicator.recycleCells()
        headingIndicator.recycleCells()
    }
    
    func setHeading(heading: Double) {
        headingIndicator.value = heading
    }
    
    func setAltitude(altitude: Double) {
//        altimeter.value = altitude
    }

    func setAirSpeed(airSpeed: Double) {
        airSpeedIndicator.value = airSpeed
    }
}

extension PrimaryFlightDisplayScene: AttitudeSettable {

    func setAttitude(attitude: AttitudeType) {
        horizon.setAttitude(attitude)
        pitchLadder.setAttitude(attitude)
        bankIndicator.setAttitude(attitude)
    }
}

func delayOnMainQueue(delay: Double, closure: ()->()) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
}
