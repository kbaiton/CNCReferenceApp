//
//  ChipLoadPickerViewModel.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-08-06.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

class ChipLoadPickerViewModel: NSObject {
    
    var chipLoads = MutableObservableArray<ChipLoad>([])
    
    override init() {
        super.init()
        self.setupChipLoads()
    }
    
    func setupChipLoads() {
        var chipLoadArray: [ChipLoad] = []
        let chipLoad = ChipLoad(value: 0.011, description: "Test Chip Load")
        chipLoadArray.append(chipLoad)
        chipLoadArray.append(chipLoad)
        chipLoadArray.append(chipLoad)
        chipLoadArray.append(chipLoad)
        
        self.chipLoads.replace(with: chipLoadArray)
    }
}

struct ChipLoad {
    var value: NSNumber
    var description: String
}
