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
    
    init(lowerValue: Int, upperValue: Int) throws {
        guard upperValue > lowerValue else { throw Error.UpperValueMustExceedLowerValue }
        
        self.lowerValue = lowerValue
        self.upperValue = upperValue
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
        return try TapeCellModel(lowerValue: upperValue, upperValue: upperValue + Int(magnitude))
    }
    
    func previous() throws -> TapeCellModel {
        return try TapeCellModel(lowerValue: lowerValue - Int(magnitude), upperValue: lowerValue)
    }
}
