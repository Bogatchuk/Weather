//
//  SearchViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 20.12.2022.
//

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    
    let searchController = UISearchController()
    //var listCities: [CitySearch]!
    
    @IBOutlet weak var tableView: UITableView!
    weak var coordinator: AppCoordinator?
    
    var viewModel: SearchViewModelProtocol!{
        didSet{
            //self.listCities = viewModel.searchedCities
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        
        self.tableView.register(CityCell.nib(), forCellReuseIdentifier: CityCell.identifire)
        self.tableView.showsVerticalScrollIndicator = false
        viewModel = SearchViewModel()
        
    }
    
    
    
}

extension SearchViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let cityName = searchController.searchBar.text else {return}
        self.viewModel.searchIsActive = searchController.isActive
        
        self.viewModel.searchCity(name: cityName) {
            self.tableView.reloadData()
        }
        
        if !searchController.isActive {
            self.tableView.reloadData()
        }
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {
            let city = self.viewModel.searchedCities[indexPath.row]
            self.viewModel.addCity(city: city)
            searchController.isActive = false
            tableView.reloadData()
            
        }else {
            self.viewModel.showWeather(at: indexPath){
                self.coordinator?.push(name: .weatherView)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.viewModel.deletCity(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])
        return swipeAction
    }
    
}
