//
//  ChipLoadPickerViewController.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-08-06.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit
import ChameleonFramework

class ChipLoadPickerViewController: UIViewController {
    
    var viewModel = ChipLoadPickerViewModel()
    var didSelectChipLoadPublishSubject = SafePublishSubject<NSNumber>()
    
    @IBOutlet weak var pickerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Avenir Heavy", size: 26)!, NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.setupBindings()
    }
    
    func setupBindings() {
        self.viewModel.chipLoads.bind(to: self.pickerTableView) { (chipLoads, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChipLoadCell")!
            let chipLoad = chipLoads[indexPath.row]
            cell.textLabel?.text = chipLoad.description
            cell.detailTextLabel?.text = CNCValueNumberFormatter.defaultFormatter.string(from: chipLoad.value)
            cell.textLabel?.textColor = FlatNavyBlue()
            cell.detailTextLabel?.textColor = FlatNavyBlue()
            return cell
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ChipLoadPickerViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let chipLoad = self.viewModel.chipLoads[indexPath.row]
        self.didSelectChipLoadPublishSubject.next(chipLoad.value)
        
        self.dismiss(animated: true, completion: nil)
    }
}
