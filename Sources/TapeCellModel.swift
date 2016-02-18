//
//  TapeCellModel.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 3/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

protocol TapeCellModelType {
    var lowerValue: Int  { get }
    var upperValue: Int  { get }
    var magnitude:  UInt { get }
    var midValue:   Double { get }

    func containsValue(value: Double) -> Bool
    func next() throws -> TapeCellModelType
    func previous() throws -> TapeCellModelType
    
    init(lowerValue: Int, upperValue: Int) throws
}

extension TapeCellModelType {
    
    var magnitude: UInt {
        return UInt(abs(upperValue - lowerValue))
    }

    var midValue: Double {
        let halfRange = (Double(upperValue) - Double(lowerValue)) / 2
        return Double(lowerValue) + halfRange
    }

    func containsValue(value: Double) -> Bool {
        return Double(lowerValue) <= value && value <= Double(upperValue)
    }
    
    func next() throws -> TapeCellModelType {
        return try Self(lowerValue: upperValue, upperValue: upperValue + Int(magnitude))
    }
    
    func previous() throws -> TapeCellModelType {
        return try Self(lowerValue: lowerValue - Int(magnitude), upperValue: lowerValue)
    }
}

enum TapeCellModelError: ErrorType {
    case UpperValueMustExceedLowerValue
}

struct ContinuousTapeCellModel: TapeCellModelType {
    let lowerValue: Int
    let upperValue: Int
    
    init(lowerValue: Int, upperValue: Int) throws {
        guard upperValue > lowerValue else { throw TapeCellModelError.UpperValueMustExceedLowerValue }
        
        self.lowerValue = lowerValue
        self.upperValue = upperValue
    }
}

struct CompassTapeCellModel: TapeCellModelType {
    let lowerValue: Int
    let upperValue: Int
    
    init(lowerValue: Int, upperValue: Int) throws {
        guard upperValue > lowerValue else { throw TapeCellModelError.UpperValueMustExceedLowerValue }
        
        self.lowerValue = lowerValue
        self.upperValue = upperValue
    }
}

extension CompassTapeCellModel {
    
    func containsValue(value: Double) -> Bool {
        let leftValue = lowerValue.compassValue
        let rightValue = upperValue.compassValue == 0 ? 360 : upperValue.compassValue
        return leftValue <= value && value <= rightValue
    }
}
