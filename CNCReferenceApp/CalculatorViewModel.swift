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
    var chipLoadSelectionPublishSubject = SafePublishSubject<Void>()
    
    override init() {
        super.init()
        
        self.setupBindings()
        
    }
    
    func setupBindings() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.openSavedCalculation(_:)), name: NSNotification.Name(rawValue: "OpenCalculationNotification"), object: nil)
        
        self.cellModels.append(CalculatorCellModel(type: .bitDiameter, units: .mm))
        self.cellModels.append(CalculatorCellModel(type: .spindleSpeed, units: .rpm))
        self.cellModels.append(CalculatorCellModel(type: .flutes, units: .none))
        self.cellModels.append(CalculatorCellModel(type: .chipLoad, units: .none))
        self.cellModels.append(CalculatorCellModel(type: .feedRate, units: .mmpm))
    }
    
    @objc func openSavedCalculation(_ notification: NSNotification) {
        
        if let savedCalculation = notification.userInfo?["Calculation"] as? SavedCalculation {
            
            if let bitDiameterModel = self.getModelWithType(.bitDiameter) {
                bitDiameterModel.setValue(savedCalculation.bitDiameter, valueUnits: .mm)
                self.replace(cellModel: bitDiameterModel)
            }
            
            if let spindleSpeedModel = self.getModelWithType(.spindleSpeed) {
                spindleSpeedModel.setValue(savedCalculation.spindleSpeed, valueUnits: .rpm)
                self.replace(cellModel: spindleSpeedModel)
            }
            
            if let flutesModel = self.getModelWithType(.flutes) {
                flutesModel.setValue(savedCalculation.numberOfFlutes, valueUnits: .none)
                self.replace(cellModel: flutesModel)
            }
            
            if let chipLoadModel = self.getModelWithType(.chipLoad) {
                chipLoadModel.setValue(savedCalculation.chipLoad, valueUnits: .none)
                self.replace(cellModel: chipLoadModel)
            }
            
            if let feedRateModel = self.getModelWithType(.feedRate) {
                feedRateModel.setValue(savedCalculation.feedRate, valueUnits: .mmpm)
                self.replace(cellModel: feedRateModel)
            }
        }
    }
    
    func getModelWithType(_ type: CalculatorCellType) -> CalculatorCellModel? {
        
        var returnValue: CalculatorCellModel?
        cellModels.array.forEach { (cellModel) in
            if (cellModel.type == type) {
                returnValue = cellModel
            }
        }
        
        return returnValue
    }
    
    func replace(cellModel: CalculatorCellModel) {
        
        let index = cellModels.array.index { (model) -> Bool in
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
    
    func saveCurrentCalculation(name: String) {
        let currentCalculation = SavedCalculation()
        currentCalculation.name = name as NSString
        currentCalculation.numberOfFlutes = self.getModelWithType(.flutes)?.getValue(with: .none) ?? 0
        currentCalculation.bitDiameter = self.getModelWithType(.bitDiameter)?.getValue(with: .mm) ?? 0
        currentCalculation.spindleSpeed = self.getModelWithType(.spindleSpeed)?.getValue(with: .rpm) ?? 0
        currentCalculation.chipLoad = self.getModelWithType(.chipLoad)?.getValue(with: .none) ?? 0
        currentCalculation.feedRate = self.getModelWithType(.feedRate)?.getValue(with: .none) ?? 0
        
        var savedCalcs = PersistentStorageService.getSavedCalculations()
        savedCalcs.append(currentCalculation)
        PersistentStorageService.setSavedCalculations(savedCalcs)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "CalulationSavedNotification"), object: self)
    }
    
    func chipLoadSelected(value: NSNumber) {
        if let cellModel = self.getModelWithType(.chipLoad) {
            cellModel.value = value
            self.replace(cellModel: cellModel)
            self.recalculateFeedRate()
        }
    }
    
    func changeUnits(cellModel: CalculatorCellModel) {
        cellModel.swapUnits()
        self.replace(cellModel: cellModel)
    }
    
    func updateModel(value: NSNumber, IndexPath: IndexPath) {
        let model = self.cellModels[IndexPath.row]
        model.setValue(value, valueUnits: model.units)
        
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
            self.chipLoadSelectionPublishSubject.next(())
    
        default:
            break
        }
    }
}
