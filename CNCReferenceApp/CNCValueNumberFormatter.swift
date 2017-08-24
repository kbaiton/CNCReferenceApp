//
//  CNCValueNumberFormatter.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-08-24.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import Foundation

class CNCValueNumberFormatter {
    
    class var defaultFormatter: NumberFormatter {
        get {
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 8
            return formatter
        }
    }
}
