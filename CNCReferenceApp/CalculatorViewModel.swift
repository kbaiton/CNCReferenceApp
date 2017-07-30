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
        self.cellModels.append(CalculatorCellModel(type: .chipLoad))
        self.cellModels.append(CalculatorCellModel(type: .feedRate))
    }
    
    func updateModel(value: NSNumber, IndexPath: IndexPath) {
        let model = self.cellModels[IndexPath.row]
        model.value = value
    }
}
