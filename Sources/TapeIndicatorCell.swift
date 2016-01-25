//
//  TapeIndicatorCell.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 23/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit


class TapeIndicatorCell: SKNode {
    
    var model: TapeIndicatorCellModel {
        didSet {
            updateLabels()
        }
    }
    private let style: TapeIndicatorCellStyle
    
    init(model: TapeIndicatorCellModel, style: TapeIndicatorCellStyle) {
        self.model = model
        self.style = style

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLabels() {
        // TODO
    }
}

struct TapeIndicatorCellModel {
    let lowerValue: Int
    let upperValue: Int
}
