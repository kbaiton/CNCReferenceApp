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
        self.cellModels.append(CalculatorCellModel(type: .bitDiameter, units: .mm))
        self.cellModels.append(CalculatorCellModel(type: .spindleSpeed, units: .rpm))
        self.cellModels.append(CalculatorCellModel(type: .flutes, units: .none))
        self.cellModels.append(CalculatorCellModel(type: .chipLoad, units: .none))
        self.cellModels.append(CalculatorCellModel(type: .feedRate, units: .mmpm))
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
    
    func replace(cellModel: CalculatorCellModel) {
        
        let index = cellModels.index { (model) -> Bool in
            model.type == cellModel.type
        }
        
        guard let unwrappedIndex = index else { return }
        
        self.cellModels[unwrappedIndex] = cellModel
    }
    
    func recalculateFeedRate() {
        let flutes = self.getValueForModelWithType(.flutes)
        let bitDiameter = self.getValueForModelWithType(.bitDiameter)
        let spindleSpeed = self.getValueForModelWithType(.spindleSpeed)
        let chipLoad = self.getValueForModelWithType(.chipLoad)
        
        let feedRate = flutes.floatValue * bitDiameter.floatValue * spindleSpeed.floatValue * chipLoad.floatValue
        
        set(value: NSNumber(value: feedRate), for: .feedRate)
    }
    
    func changeUnits(cellModel: CalculatorCellModel) {
        cellModel.swapUnits()
        self.replace(cellModel: cellModel)
    }
    
    func updateModel(value: NSNumber, IndexPath: IndexPath) {
        let model = self.cellModels[IndexPath.row]
        model.value = value
        
        self.recalculateFeedRate()
    }
    
    func modelOptionsButtonTapped(indexPath: IndexPath) {
        let cellModel = self.cellModels[indexPath.row]
        switch cellModel.type {
        case .bitDiameter, .feedRate:
            self.changeUnits(cellModel: cellModel)
        case .chipLoad:
            print("Show chip load list")
    
        default:
            break
        }
    }
}
