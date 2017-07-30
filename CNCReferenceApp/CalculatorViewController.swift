//
//  CalculatorViewController.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-07-23.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var viewModel = CalculatorViewModel()
    
    @IBOutlet weak var calculatorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBindings()
    }
    
    func setupBindings() {
        self.viewModel.cellTypes.bind(to: self.calculatorTableView) { (cellTypes, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalculatorCell") as! CalculatorTableViewCell
            cell.initWith(cellType: cellTypes[indexPath.row])
            return cell
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
