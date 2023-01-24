//
//  SearchViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 15.01.2023.
//

import Foundation

protocol SearchViewModelProtocol {
    var searchIsActive: Bool { get set}
    var listCities:[CitySearch] {get}
    func addCity(city: CitySearch)
    func deletCity(city: CitySearch)
    func getWeather(city: String, completion: @escaping () -> ())
    func cellViewModel(at indexPath: IndexPath, list: [CitySearch]) -> CityCellViewModelProtocol
}

class SearchViewModel: SearchViewModelProtocol{
    
    var listCities: [CitySearch] {
        get{
            StorageManager.shared.getListCities() ?? []
        }
    }
    var searchIsActive: Bool = false
    
    func addCity(city: CitySearch){
        StorageManager.shared.saveCityToSearch(city: city)
    }
    
    func deletCity(city: CitySearch){
        StorageManager.shared.delete(city)
    }
    
    func cellViewModel(at indexPath: IndexPath, list: [CitySearch] ) -> CityCellViewModelProtocol {
        let city = list[indexPath.row]
        return CityCellViewModel(foundCity: city)
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
    
    
    
}
