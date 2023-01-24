//
//  BootViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 11.01.2023.
//

import UIKit
import CoreLocation



class StartViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    let dataFetcherService = DataFetcherService()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        activityIndicator.startAnimating()
        
    }
    
    func getWeatherData(location: CLLocation?){
        if let location = location {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let group = DispatchGroup()
            
            group.enter()
            dataFetcherService.fetchForecastWeather(latitude: lat, longitude: lon) { forecastWeather in
                guard let forecastWeather = forecastWeather else {return}
                let city = CitySearch(city: forecastWeather.city!)
                StorageManager.shared.saveCityToSearch(city: city)
                StorageManager.shared.saveForecastWeather(forecastWeather: forecastWeather)
                group.leave()
                
            }
            group.enter()
            dataFetcherService.fetchCurrentWeather(latitude: lat, longitude: lon) { currentWeather in
                guard let currentWeather = currentWeather else {return}
                StorageManager.shared.saveCurrentWeather(currentWeather: currentWeather)
                group.leave()
            }
            
            group.notify(queue: .main) {
                print("Finish Fetch")
                self.activityIndicator.stopAnimating()
                self.coordinator?.showWeatherView()
            }
            
        }
    }
    
}

extension StartViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getWeatherData(location: locations.last)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status.rawValue == 4 {
            getWeatherData(location: manager.location)
        }
       
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
