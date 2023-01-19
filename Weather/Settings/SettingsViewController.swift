//
//  SettingsViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 20.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    var button = ["Температура", "Ветер", "Давление", "Атмосферные осадки", "Формат времени"]
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.separatorStyle = .none
    }
}

extension SettingsViewController: UITableViewDelegate{
    
}

extension SettingsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return button.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        var content = cell?.defaultContentConfiguration()
        content?.text = button[indexPath.row]
        cell?.contentConfiguration = content
        return cell!
    }
    
    
}
