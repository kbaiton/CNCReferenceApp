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
    
    func getModelWithType(_ type: CalculatorCellType) -> CalculatorCellModel? {
        
        var returnValue: CalculatorCellModel?
        cellModels.forEach { (cellModel) in
            if (cellModel.type == type) {
                returnValue = cellModel
            }
        }
        
        return returnValue
    }
    
    func replace(cellModel: CalculatorCellModel) {
        
        let index = cellModels.index { (model) -> Bool in
            model.type == cellModel.type
        }
        
        guard let unwrappedIndex = index else { return }
        
        self.cellModels[unwrappedIndex] = cellModel
    }
    
    func recalculateFeedRate() {
        let flutes = self.getModelWithType(.flutes)?.getValue(with: .none) ?? 0
        let bitDiameter = self.getModelWithType(.bitDiameter)?.getValue(with: .mm) ?? 0
        let spindleSpeed = self.getModelWithType(.spindleSpeed)?.getValue(with: .rpm) ?? 0
        let chipLoad = self.getModelWithType(.chipLoad)?.getValue(with: .none) ?? 0
        
        let feedRate = flutes.floatValue * bitDiameter.floatValue * spindleSpeed.floatValue * chipLoad.floatValue
        
        if let feedRateModel = self.getModelWithType(.feedRate) {
            feedRateModel.setValue(NSNumber(value: feedRate), valueUnits: .mmpm)
            self.replace(cellModel: feedRateModel)
        }
        
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
    
    func formatModel(IndexPath: IndexPath) {
        let cellModel = self.cellModels[IndexPath.row]
        self.replace(cellModel: cellModel)
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
