//
//  HourCellViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 14.01.2023.
//

import Foundation

protocol HourCellViewModelProtocol: AnyObject{
    var temp: String { get }
    var time: String { get }
    var iconName: String { get }
    init(weatherForTheDay: WeatherLists, timezone: Int)
}

class HourCellViewModel: HourCellViewModelProtocol{
    
    var temp: String{
       "\(String(describing: Int(weatherForTheDay.main!.temp))) ℃"
        
    }
    
    var time: String {
        DateManager.shared.getHoure(date: weatherForTheDay.dt_txt, timezone: timezone)

    }
    
    var iconName: String{
        "\(String(describing: weatherForTheDay.weather.first!.icon))"
    }
    
    private let weatherForTheDay: WeatherLists
    private let timezone: Int
    required init(weatherForTheDay: WeatherLists, timezone: Int) {
        self.weatherForTheDay = weatherForTheDay
        self.timezone = timezone
        
    }
    
    
}
