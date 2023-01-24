//
//  SearchViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 20.12.2022.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    
    let searchController = UISearchController()
    let dataFetcherService = DataFetcherService()
    var listCities: [CitySearch]!
    var load = false
    @IBOutlet weak var tableView: UITableView!
    weak var coordinator: AppCoordinator?
    
    var viewModel: SearchViewModelProtocol!{
        didSet{
            self.listCities = viewModel.listCities
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
    
    func updateSearchResults(for searchController: UISearchController) {
        self.listCities = []
        self.tableView.reloadData()
        
        guard let cityName = searchController.searchBar.text else {return}
        dataFetcherService.featchCity(city: cityName) { city in
            guard let city = city else {return}
           
            self.listCities = city.map({ city in
                CitySearch(city: city)
            })
            self.tableView.reloadData()
        }
        
        if !searchController.isActive {
            self.listCities = viewModel.listCities
            self.tableView.reloadData()
        }
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath, list: self.listCities)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {

            guard let city = self.listCities.first else {return}
            self.viewModel.addCity(city: city)
            self.listCities = viewModel.listCities
            searchController.isActive = false
            tableView.reloadData()
            
        }else{
            
            let city = self.listCities[indexPath.row].city
            self.viewModel.getWeather(city: city){
                self.coordinator?.showWeatherView()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let city = listCities[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.viewModel.deletCity(city: city)
            self.listCities = self.viewModel.listCities
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])
        return swipeAction
    }
    
}
