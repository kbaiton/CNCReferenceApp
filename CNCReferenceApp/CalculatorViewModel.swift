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
    
    var cellTypes = MutableObservableArray<CalculatorCellType>([])
    
    override init() {
        super.init()
        
        self.setupBindings()
    }
    
    func setupBindings() {
        self.cellTypes.append(.bitDiameter)
        self.cellTypes.append(.chipLoad)
        self.cellTypes.append(.spindleSpeed)
        self.cellTypes.append(.feedRate)
        
    }
}
