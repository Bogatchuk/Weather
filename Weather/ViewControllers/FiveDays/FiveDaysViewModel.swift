//
//  FiveDaysViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 14.01.2023.
//

import Foundation

protocol FiveDaysViewModelProtocol: AnyObject{
    var forecastWeather: [WeatherLists] {get}
    var numberOfRows: Int {get}
    func cellViewModel(at indexPath: IndexPath) -> DayCellViewModelProtocol
}

class FiveDaysViewModel: FiveDaysViewModelProtocol {
    
    var forecastWeather: [WeatherLists] {
        let weatherLists = StorageManager.shared.getForecastWeather()
        var resultArray = Array<WeatherLists>()
        for weather in weatherLists!.list {
            resultArray.append(weather)
        }
        return resultArray
    }
    
    var numberOfRows: Int {
        forecastWeather.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> DayCellViewModelProtocol {
        let dailyWeatherForecast = forecastWeather.filter({ list in
            DateService.getDateFromString(date: list.dt_txt, timezone: nil) == DateService.getDateRelativeToToday(add: indexPath.row)
        
        })
        return DayCellViewModel(weatherForTheDay: dailyWeatherForecast)
    }
}
