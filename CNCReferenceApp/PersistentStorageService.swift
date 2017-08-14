//
//  PersistentStorageService.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-08-14.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import Foundation

class PersistentStorageService {
    
    static func savedCalculationFilePath() -> String {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return "" }
        return url.appendingPathComponent("SavedCalculations").path
    }
    
    static func getSavedCalculations() -> [SavedCalculation] {
        
        
        if let savedCalculations = NSKeyedUnarchiver.unarchiveObject(withFile: self.savedCalculationFilePath()) as? [SavedCalculation] {
            return savedCalculations
        }
        
        return []
    }
    
    static func setSavedCalculations(_ calculations: [SavedCalculation]) {
        NSKeyedArchiver.archiveRootObject(calculations, toFile: self.savedCalculationFilePath())
    }
    
}
