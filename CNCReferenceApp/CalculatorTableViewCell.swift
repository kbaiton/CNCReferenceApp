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
    @IBOutlet weak var cellButton: UIButton!
    
    func initWith(cellModel: CalculatorCellModel) {
        
        self.titleLabel.text = cellModel.type.description + self.getUnitString(cellModel: cellModel)
        
        self.inputField.isEnabled = (cellModel.type != .feedRate)
        self.inputField.text = cellModel.value.stringValue
        self.inputField.addDoneButtonToKeyboard(myAction: #selector(self.inputField.resignFirstResponder))
        
        self.cellButton.isHidden = cellModel.type.buttonHidden
        self.cellButton.setTitle(cellModel.type.optionsButtonText, for: .normal)
    }
    
    func getUnitString(cellModel: CalculatorCellModel) -> String {
        if cellModel.units == .none {
            return ""
        } else {
            return " (\(cellModel.units.description))"
        }
    }
}

class CalculatorCellModel {
    var type: CalculatorCellType
    var units: CalculatorCellUnits
    var value: NSNumber
    
    init(type: CalculatorCellType, units: CalculatorCellUnits) {
        self.type = type
        self.value = 0
        self.units = units
    }
    
    func swapUnits() {
        if (self.units == .mm) {
            self.units = .inches
            self.value = NSNumber(value: self.value.floatValue * 0.03937007874)
        } else if (self.units == .inches) {
            self.units = .mm
            self.value = NSNumber(value: self.value.floatValue * 25.4)
        } else if (self.units == .mmpm) {
            self.units = .ipm
            self.value = NSNumber(value: self.value.floatValue * 0.03937007874)
        } else if (self.units == .ipm) {
            self.units = .mmpm
            self.value = NSNumber(value: self.value.floatValue * 25.4)
        }
    }
}

enum CalculatorCellUnits {
    case none
    case rpm
    case mm
    case inches
    case mmpm
    case ipm
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .rpm:
            return "RPM"
        case .mm:
            return "mm"
        case .inches:
            return "inches"
        case .mmpm:
            return "mm/min"
        case .ipm:
            return "ipm"
        }
    }
}

enum CalculatorCellType {
    case feedRate
    case spindleSpeed
    case bitDiameter
    case chipLoad
    case flutes
    
    var description: String {
        switch self {
        case .feedRate:
            return NSLocalizedString("Feed Rate", comment: "")
        case .spindleSpeed:
            return NSLocalizedString("Spindle Speed", comment: "")
        case .bitDiameter:
            return NSLocalizedString("Bit Diameter", comment: "")
        case .chipLoad:
            return NSLocalizedString("Chip Load", comment: "")
        case .flutes:
            return NSLocalizedString("Number of Flutes", comment: "")
        }
    }
    
    var optionsButtonText: String {
        switch self {
        case .feedRate:
            return NSLocalizedString("Change Units", comment: "")
        case .bitDiameter:
            return NSLocalizedString("Change Units", comment: "")
        case .chipLoad:
            return NSLocalizedString("Select from list", comment: "")
        default:
            return ""
        }
    }
    
    var buttonHidden: Bool {
        switch self {
        case .feedRate, .bitDiameter, .chipLoad:
            return false
        default:
            return true
        }
    }
    
}
