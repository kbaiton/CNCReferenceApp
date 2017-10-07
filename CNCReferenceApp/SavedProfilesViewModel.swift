//
//  SavedProfilesViewModel.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-08-14.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

class SavedProfilesViewModel: NSObject {
    
    var savedCalculations = MutableObservableArray<SavedCalculation>([])
    
    override init() {
        super.init()
    
        self.loadSavedCalculations()
        self.setupBindings()
    }
    
    @objc func loadSavedCalculations() {

        self.savedCalculations.replace(with: PersistentStorageService.getSavedCalculations())
    }
    
    func setupBindings() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadSavedCalculations), name: NSNotification.Name(rawValue: "CalulationSavedNotification"), object: nil)
    }
    
    func openCalculationinCalculator(indexPath: IndexPath) {
        let openCalc = savedCalculations[indexPath.row]
        let openCalcDict:[String: SavedCalculation] = ["Calculation": openCalc]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "OpenCalculationNotification"), object: nil, userInfo: openCalcDict)
    }
    
    func deleteSavedCalculation(indexPath: IndexPath) {
        self.savedCalculations.remove(at: indexPath.row)
        PersistentStorageService.setSavedCalculations(self.savedCalculations.array)
    }

}
