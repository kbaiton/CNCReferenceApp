//
//  CalculatorViewModel.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-07-30.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

class CalculatorViewModel: NSObject {
    
    var cellModels = MutableObservableArray<CalculatorCellModel>([])
    
    override init() {
        super.init()
        
        self.setupBindings()
    }
    
    func setupBindings() {
        self.cellModels.append(CalculatorCellModel(type: .bitDiameter))
        self.cellModels.append(CalculatorCellModel(type: .spindleSpeed))
        self.cellModels.append(CalculatorCellModel(type: .flutes))
        self.cellModels.append(CalculatorCellModel(type: .chipLoad))
        self.cellModels.append(CalculatorCellModel(type: .feedRate))
    }
    
    func getValueForModelWithType(_ type: CalculatorCellType) -> NSNumber {
        
        var returnValue: NSNumber = 0
        cellModels.forEach { (cellModel) in
            if (cellModel.type == type) {
                returnValue = cellModel.value
            }
        }
        
        return returnValue
    }
    
    func set(value: NSNumber, for type:CalculatorCellType) {
        cellModels.forEach { (cellModel) in
            if (cellModel.type == type) {
                cellModel.value = value
            }
        }
    }
    
    func recalculateFeedRate() {
        let flutes = self.getValueForModelWithType(.flutes)
        let bitDiameter = self.getValueForModelWithType(.bitDiameter)
        let spindleSpeed = self.getValueForModelWithType(.spindleSpeed)
        let chipLoad = self.getValueForModelWithType(.chipLoad)
        
        let feedRate = flutes.floatValue * bitDiameter.floatValue * spindleSpeed.floatValue * chipLoad.floatValue
        
        set(value: NSNumber(value: feedRate), for: .feedRate)
    }
    
    func updateModel(value: NSNumber, IndexPath: IndexPath) {
        let model = self.cellModels[IndexPath.row]
        model.value = value
        
        self.recalculateFeedRate()
    }
}
