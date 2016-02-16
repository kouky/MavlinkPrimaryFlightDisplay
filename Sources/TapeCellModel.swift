//
//  TapeCellModel.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 3/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

struct TapeCellModel {
    
    enum Error: ErrorType {
        case UpperValueMustExceedLowerValue
    }
    
    let lowerValue: Int
    let upperValue: Int
    var magnitude: UInt {
        return UInt(abs(upperValue - lowerValue))
    }
    private let isCompass: Bool
    
    init(lowerValue: Int, upperValue: Int, isCompass: Bool = false) throws {
        guard upperValue > lowerValue else { throw Error.UpperValueMustExceedLowerValue }
        
        self.lowerValue = lowerValue
        self.upperValue = upperValue
        self.isCompass = isCompass
    }
    
    var midValue: Double {
        let halfRange = (Double(upperValue) - Double(lowerValue)) / 2
        return Double(lowerValue) + halfRange
    }
    
    func containsValue(value: Double) -> Bool {
        return Double(lowerValue) <= value && value <= Double(upperValue)
    }
}

extension TapeCellModel: DuplexGeneratorType {
    
    func next() throws -> TapeCellModel {
        var newUpperValue = upperValue + Int(magnitude)
        if isCompass {
            newUpperValue %= Int(magnitude)
        }
        return try TapeCellModel(lowerValue: upperValue, upperValue: newUpperValue, isCompass: isCompass)
    }
    
    func previous() throws -> TapeCellModel {
        var newLowerValue = lowerValue - Int(magnitude)
        if isCompass {
            newLowerValue %= Int(magnitude)
        }
        return try TapeCellModel(lowerValue: newLowerValue, upperValue: lowerValue, isCompass: isCompass)
    }
}
