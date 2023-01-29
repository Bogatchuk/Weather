//
//  StartViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.01.2023.
//

import UIKit
import CoreLocation

protocol StartViewModelProtocol: AnyObject {
    func getWeatherData(location: CLLocation, completion: @escaping () -> ())
}

class StartViewModel: StartViewModelProtocol {
    let locationService = LocationService()
    var locationCallback: ((CLLocation) -> ())?
    var errorCallback: ((Error) -> Void)?
    
    init(){
        locationService.locationManager.delegate = locationService
    }
    
    func startUpdatingLocation() {
        locationService.locationCallback = { [weak self] location in
            guard let self = self else { return }
            if let location = location {
                self.locationCallback?(location)
            }
            
        }
        
        locationService.errorCallback = { error in
            self.errorCallback?(error)
        }
        //locationService.startUpdatingLocation()
    }
    
    func showErrorMessage() {
        SharedClass.sharedInstance.alertWindow(title:"Error", message:"To display the weather, you need to go to Settings -> Weather-> Allow access to geolocation")
    }
    
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
            completion()
        }
    }
}



