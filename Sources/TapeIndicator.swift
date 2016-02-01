//
//  TapeIndicator.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 18/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit


class TapeIndicator: SKNode {
    
    let style: TapeIndicatorStyle
    var value: Double = 0 {
        didSet {
            updateCellPositions()
        }
    }
    private let cellPool: StaticPool<TapeIndicatorCell>
    private let cellPoolSize: UInt = 3
    
    init(style: TapeIndicatorStyle) {
        self.style = style
        cellPool = StaticPool.build(size: cellPoolSize) {
            let cellModel = TapeIndicatorCellModel(lowerValue: 0, upperValue: 1)
            return TapeIndicatorCell(model: cellModel, style: style.cellStyle)
        }
        super.init()
        addBackgroundNode()
        addCellNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addBackgroundNode() {
        let backgroundShape = SKShapeNode(rectOfSize: style.size, cornerRadius: 2)
        backgroundShape.fillColor = style.backgroundColor
        backgroundShape.strokeColor = SKColor.clearColor()
        addChild(backgroundShape)
    }
    
    private func addCellNodes() {
        
        let models: [TapeIndicatorCellModel] = (0..<Int(cellPoolSize)).map { index in
            let valueRange = style.optimalCellValueRange
            let lowerValue = index * (valueRange + 1)
            let upperValue = lowerValue + valueRange
            return TapeIndicatorCellModel(lowerValue: lowerValue, upperValue: upperValue)
        }
        
        models.forEach { model in
            guard let cell = try? cellPool.requestElement() else {
                fatalError("Cell pool unable to provide cell")
            }
            cell.model = model
            addChild(cell)
        }
        
        value = 0
    }
    
    private func optimalCellModelForLowerValue(lowerValue: Int) -> TapeIndicatorCellModel {
        
        switch style.range {
        case .Continuous:
            return TapeIndicatorCellModel(
                lowerValue: lowerValue,
                upperValue: lowerValue + style.optimalCellValueRange)
        case .Loop(let range):
            return TapeIndicatorCellModel(
                lowerValue: lowerValue, upperValue:
                (lowerValue + style.optimalCellValueRange) % range.endIndex)
        }
    }
    
    private func updateCellPositions() {
        cellPool.forEach { [weak self] cell in
            guard let value = self?.value else { return  }
            cell.runAction(cell.actionForValue(value))
        }
    }
}
