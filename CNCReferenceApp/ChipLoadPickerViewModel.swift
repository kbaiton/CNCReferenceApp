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
        chipLoadArray.append(ChipLoad(value: 0.003, description: "1/8\" Bit - Hardwood"))
        chipLoadArray.append(ChipLoad(value: 0.004, description: "1/8\" Bit - Softwood"))
        chipLoadArray.append(ChipLoad(value: 0.004, description: "1/8\" Bit - MDF"))
        chipLoadArray.append(ChipLoad(value: 0.003, description: "1/8\" Bit - Soft Plastic"))
        chipLoadArray.append(ChipLoad(value: 0.002, description: "1/8\" Bit - Hard Plastic"))
        
        chipLoadArray.append(ChipLoad(value: 0.009, description: "1/4\" Bit - Hardwood"))
        chipLoadArray.append(ChipLoad(value: 0.011, description: "1/4\" Bit - Softwood"))
        chipLoadArray.append(ChipLoad(value: 0.013, description: "1/4\" Bit - MDF"))
        chipLoadArray.append(ChipLoad(value: 0.007, description: "1/4\" Bit - Soft Plastic"))
        chipLoadArray.append(ChipLoad(value: 0.006, description: "1/4\" Bit - Hard Plastic"))
        
        chipLoadArray.append(ChipLoad(value: 0.015, description: "3/8\" Bit - Hardwood"))
        chipLoadArray.append(ChipLoad(value: 0.017, description: "3/8\" Bit - Softwood"))
        chipLoadArray.append(ChipLoad(value: 0.020, description: "3/8\" Bit - MDF"))
        chipLoadArray.append(ChipLoad(value: 0.010, description: "3/8\" Bit - Soft Plastic"))
        chipLoadArray.append(ChipLoad(value: 0.008, description: "3/8\" Bit - Hard Plastic"))
        
        chipLoadArray.append(ChipLoad(value: 0.019, description: "1/2\" Bit - Hardwood"))
        chipLoadArray.append(ChipLoad(value: 0.021, description: "1/2\" Bit - Softwood"))
        chipLoadArray.append(ChipLoad(value: 0.025, description: "1/2\" Bit - MDF"))
        chipLoadArray.append(ChipLoad(value: 0.012, description: "1/2\" Bit - Soft Plastic"))
        chipLoadArray.append(ChipLoad(value: 0.010, description: "1/2\" Bit - Hard Plastic"))
        
        self.chipLoads.replace(with: chipLoadArray)
    }
}

struct ChipLoad {
    var value: NSNumber
    var description: String
}
