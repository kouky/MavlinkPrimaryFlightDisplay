//
//  TapeCellModel.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 3/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

struct TapeCellModel {
    
    enum Error: ErrorType {
        case UpperValueMusExceedLowerValue
        case InvalidLoop
    }
    
    let lowerValue: Int
    let upperValue: Int
    let magnitude: UInt
    private let isLoop: Bool
    
    init(lowerValue: Int, upperValue: Int, isLoop: Bool = false) throws {
        guard upperValue > lowerValue else { throw Error.UpperValueMusExceedLowerValue }

        let magnitude = upperValue - lowerValue
        if isLoop && upperValue % magnitude == 0 { throw Error.InvalidLoop }
        if isLoop && lowerValue % magnitude == 0 { throw Error.InvalidLoop }
        
        self.lowerValue = lowerValue
        self.upperValue = upperValue
        self.isLoop = isLoop
        self.magnitude = UInt(magnitude)
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
        return try TapeCellModel(lowerValue: upperValue, upperValue: upperValue + Int(magnitude), isLoop: isLoop)
    }
    
    func previous() throws -> TapeCellModel {
        return try TapeCellModel(lowerValue: lowerValue - Int(magnitude), upperValue: lowerValue, isLoop: isLoop)
    }
}
