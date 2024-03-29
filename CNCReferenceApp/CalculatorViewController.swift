//
//  CalculatorViewController.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-07-23.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import UIKit
import Foundation
import ChameleonFramework

class CalculatorViewController: UIViewController {
    
    var viewModel = CalculatorViewModel()
    
    @IBOutlet weak var calculatorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Avenir Heavy", size: 26)!, NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.setupBindings()
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Enter a name for your calculation", message: "", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            if let input = alert?.textFields?[0].text {
                print(input)
                self.tabBarController?.selectedIndex = 1
                self.viewModel.saveCurrentCalculation(name: input)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupBindings() {
        self.viewModel.cellModels.bind(to: self.calculatorTableView) { (cellModels, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalculatorCell") as! CalculatorTableViewCell
            let cellModel = cellModels[indexPath.row]
            cell.initWith(cellModel:  cellModel)
            cell.cellButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
            cell.inputField.delegate = self
            return cell
        }.dispose(in: reactive.bag)
        
        self.viewModel.chipLoadSelectionPublishSubject.observeNext {
            self.showChipLoadPicker()
        }.dispose(in: reactive.bag)
        
    }
    
    @objc func buttonTapped(sender: UIButton) {
        self.view.endEditing(true)
        
        if let cell = sender.superview?.superview?.superview as? UITableViewCell, let indexPath = self.calculatorTableView.indexPath(for: cell) {
            self.viewModel.modelOptionsButtonTapped(indexPath: indexPath)
        }
    }
    
    func showChipLoadPicker() {
        DispatchQueue.main.async {
            let chipLoadPickerNav = UIStoryboard(name: "ChipLoadPickerStoryboard", bundle: nil).instantiateInitialViewController() as! UINavigationController
            let chipLoadPickerVC = chipLoadPickerNav.topViewController as! ChipLoadPickerViewController

            chipLoadPickerVC.didSelectChipLoadPublishSubject.observeNext(with: { (chipLoadValue) in
                self.viewModel.chipLoadSelected(value: chipLoadValue)
            }).dispose(in: chipLoadPickerVC.reactive.bag)
            
            self.present(chipLoadPickerNav, animated: true, completion: nil)
        }
    }
    
}

extension CalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do something with selected row
    }
}

extension CalculatorViewController: UITextFieldDelegate {
    
    func getCellForTextField(_ textField: UITextField) -> UITableViewCell? {
        return textField.superview?.superview as? UITableViewCell
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.text == "0") {
            textField.text = ""
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        var returnValue = false
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let newValue = numberFormatter.number(from: newString)
        
        if (newValue != nil || newString == "" || newString == ".") {
            returnValue = true
            //find cell model and update from input
            if let cell = self.getCellForTextField(textField), let indexPath = self.calculatorTableView.indexPath(for: cell) {
                self.viewModel.updateModel(value: newValue ?? 0, IndexPath: indexPath)
            }
        }
        
        return returnValue
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //find cell model and update from input
        if let cell = self.getCellForTextField(textField), let indexPath = self.calculatorTableView.indexPath(for: cell) {
            self.viewModel.formatModel(IndexPath: indexPath)
        }
    }
    
    
}
