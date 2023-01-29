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
    let weatherLists = StorageManager.shared.getForecastWeather()
    
    var forecastWeather: [WeatherLists] {
    
        var resultArray = Array<WeatherLists>()
        if let weatherLists = weatherLists?.list {
            for weather in weatherLists {
                resultArray.append(weather)
            }
        }
        return resultArray
    }
    
    var numberOfRows: Int {
        5
    }
    
    func cellViewModel(at indexPath: IndexPath) -> DayCellViewModelProtocol {
        let dailyWeatherForecast = forecastWeather.filter({ list in
            DateService.getDateFromString(date: list.dt_txt, timezone: weatherLists?.city?.timezone) == DateService.getDateRelativeToToday(add: indexPath.row, timezone: weatherLists?.city?.timezone)
        
        })
        
        return DayCellViewModel(weatherForTheDay: dailyWeatherForecast)
    }
}
