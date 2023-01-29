//
//  MainViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 27.01.2023.
//

import Foundation


import RealmSwift

protocol MainViewModelProtocol: AnyObject {
    var cityName: String {get}
   
}

class MainViewModel: MainViewModelProtocol {
    var cityName: String {
        weather?.city?.name ?? "City"
    }
    
    private let weather: ForecastWeatherModel?
    init() {
        weather = StorageManager.shared.getForecastWeather()
    }
}


