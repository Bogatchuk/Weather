//
//  SearchViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 15.01.2023.
//

import Foundation

protocol SearchViewModelProtocol {
    var searchIsActive: Bool { get set}
    var searchedCities: [CitySearch] { get set }
    func addCity(city: CitySearch)
    func deletCity(at indexPath: IndexPath)
    func getWeather(city: String, completion: @escaping () -> ())
    func searchCity(name: String?, completion: @escaping () -> ())
    func showWeather(at indexPath: IndexPath, completion: @escaping () -> ())
    func getCitiesFromStorage() -> [CitySearch]
    func cellViewModel(at indexPath: IndexPath) -> CityCellViewModelProtocol
    var numberOfRows: Int { get }
}

class SearchViewModel: SearchViewModelProtocol{
    var numberOfRows: Int {
        return searchIsActive ? searchedCities.count : getCitiesFromStorage().count
    }
    
    var searchedCities: [CitySearch] = []
    
    var searchIsActive: Bool = false
    
    func addCity(city: CitySearch){
        StorageManager.shared.saveCityToSearch(city: city)
    }
    
    func deletCity(city: CitySearch){
        do {
            try StorageManager.shared.delete(city)
        } catch {
            // handle error
        }
    }
    
    func deletCity(at indexPath: IndexPath){
        let cities = getCitiesFromStorage()
        do {
            try StorageManager.shared.delete(cities[indexPath.row])
        } catch {
            // handle error
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CityCellViewModelProtocol {
        let listCities = searchIsActive ? searchedCities : getCitiesFromStorage()
        let cities = listCities[indexPath.row]
        return CityCellViewModel(foundCity: cities)
    }
    
    func showWeather(at indexPath: IndexPath, completion: @escaping () -> ()) {
        let city = getCitiesFromStorage()
        getWeather(city: city[indexPath.row].city) {
            completion()
        }
    }
    
    func getWeather(city: String, completion: @escaping () -> ()){
        let group = DispatchGroup()
        group.enter()
        DataFetcherService.fetchForecastWeather(city: city) { forecastWeather in
            guard let forecastWeather = forecastWeather else {return}
            StorageManager.shared.saveForecastWeather(forecastWeather: forecastWeather)
            group.leave()
        }
        
        group.enter()
        DataFetcherService.fetchCurrentWeather(city: city) { currentWeather in
            guard let currentWeather = currentWeather else {return}
            StorageManager.shared.saveCurrentWeather(currentWeather: currentWeather)
            group.leave()
        }
        group.notify(queue: .main) {
            completion()
        }
        
    }
    
    func getCitiesFromStorage() -> [CitySearch] {
        return StorageManager.shared.getListCities() ?? []
    }
    
    func searchCity(name: String?, completion: @escaping () -> ()){

        DataFetcherService.featchCity(city: name!) { city in
            guard let city = city else {return}
            
            self.searchedCities = city.map({ city in
                CitySearch(city: city)
            })
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
