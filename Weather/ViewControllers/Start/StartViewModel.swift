//
//  StartViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.01.2023.
//

import Foundation
import CoreLocation

protocol StartViewModelProtocol: AnyObject {
    func getWeatherData(location: CLLocation, completion: @escaping () -> ())
}

class StartViewModel: StartViewModelProtocol {
    
    func getWeatherData(location: CLLocation, completion: @escaping () -> ()){
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let group = DispatchGroup()
        
        group.enter()
        DataFetcherService.fetchForecastWeather(latitude: lat, longitude: lon) { forecastWeather in
            guard let forecastWeather = forecastWeather else {return}
            let city = CitySearch(city: forecastWeather.city!)
            StorageManager.shared.saveCityToSearch(city: city)
            StorageManager.shared.saveForecastWeather(forecastWeather: forecastWeather)
            group.leave()
            
        }
        group.enter()
        DataFetcherService.fetchCurrentWeather(latitude: lat, longitude: lon) { currentWeather in
            guard let currentWeather = currentWeather else {return}
            StorageManager.shared.saveCurrentWeather(currentWeather: currentWeather)
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("Finish Fetch")
            completion()
            
        }
        
    }
}


