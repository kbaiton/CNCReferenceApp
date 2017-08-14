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
    
    func loadSavedCalculations() {

        
        self.savedCalculations.replace(with: PersistentStorageService.getSavedCalculations())
    }
    
    func setupBindings() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadSavedCalculations), name: NSNotification.Name(rawValue: "CalulationSavedNotification"), object: nil)
    }

}
