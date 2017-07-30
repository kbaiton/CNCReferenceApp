//
//  CalculatorTableViewCell.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-07-30.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import UIKit

class CalculatorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    func initWith(cellModel: CalculatorCellModel) {
        
        self.titleLabel.text = cellModel.type.description
        
        self.inputField.isEnabled = (cellModel.type != .feedRate)
        self.inputField.text = cellModel.value.stringValue
        
        self.inputField.addDoneButtonToKeyboard(myAction: #selector(self.inputField.resignFirstResponder))
    }
    
    func doneAction() {
        self.inputField.endEditing(true)
    }

}

class CalculatorCellModel {
    var type: CalculatorCellType
    var value: NSNumber
    
    init(type: CalculatorCellType) {
        self.type = type
        self.value = 0
    }
}

enum CalculatorCellType {
    case feedRate
    case spindleSpeed
    case bitDiameter
    case chipLoad
    
    var description: String {
        switch self {
        case .feedRate:
            return NSLocalizedString("Feed Rate (mm/min)", comment: "")
        case .spindleSpeed:
            return NSLocalizedString("Spindle Speed (RPM)", comment: "")
        case .bitDiameter:
            return NSLocalizedString("Bit Diameter (mm)", comment: "")
        case .chipLoad:
            return NSLocalizedString("Chip Load (???)", comment: "")
        }
    }
    
}
