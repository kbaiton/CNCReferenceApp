//
//  SavedProfilesViewController.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-07-23.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import UIKit
import ChameleonFramework
import Bond
import ReactiveKit

class SavedProfilesViewController: UIViewController {
    
    @IBOutlet weak var savedCalculationsTable: UITableView!
    var viewModel = SavedProfilesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBindings()
    }
    
    func setupBindings() {
        
        self.savedCalculationsTable.reactive.delegate.forwardTo = self
        self.savedCalculationsTable.reactive.dataSource.forwardTo = self
        
        self.viewModel.savedCalculations.bind(to: self.savedCalculationsTable) { (savedCalculations, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCalculationCell")!
            let savedCalculation = savedCalculations[indexPath.row]
            cell.textLabel?.text = savedCalculation.name.length > 0 ? savedCalculation.name as String : "Saved Calculation"
            cell.textLabel?.textColor = FlatNavyBlue()
            cell.detailTextLabel?.textColor = FlatNavyBlue()
            return cell
        }.dispose(in: reactive.bag)
        
    }
}

extension SavedProfilesViewController: UITableViewDelegate, UITableViewDataSource {
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
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.openCalculationinCalculator(indexPath: indexPath)
        self.tabBarController?.selectedIndex = 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("delete pls")
    }
}

