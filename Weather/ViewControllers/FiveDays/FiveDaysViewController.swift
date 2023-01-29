//
//  FiveDaysViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 23.12.2022.
//

import UIKit

class FiveDaysViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FiveDaysViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FiveDaysViewModel()

        tableView.register(DayCell.nib(), forCellReuseIdentifier: DayCell.identifire)
        tableView.showsVerticalScrollIndicator = false
        
    }
}

extension FiveDaysViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
}
