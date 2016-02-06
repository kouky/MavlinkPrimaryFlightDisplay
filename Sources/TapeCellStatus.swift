//
//  TapeCellStatus.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 3/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

typealias TapeCellStatus = (valueForPosition: Double, containsValueForPosition: Bool, modelMidValue: Double, cell: TapeCell)

extension CollectionType where Self.Generator.Element: TapeCell {
    
    func statusForPosition() -> [TapeCellStatus] {
        return map { cell -> TapeCellStatus in
            let currentValue = cell.valueForPosition()
            return (currentValue, cell.model.containsValue(currentValue), cell.model.midValue, cell)
        }
        .sort { (status1, status2) in
            status1.modelMidValue < status2.modelMidValue
        }
    }
}

