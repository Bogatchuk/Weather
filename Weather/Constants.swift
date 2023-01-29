//
//  Constants.swift
//  Weather
//
//  Created by Roma Bogatchuk on 23.01.2023.
//

import Foundation

struct Constants{
    static let fullDay = 8
    static let middayIndex = 4
    
    struct WeatherURL{
        static let baseApiUrl = "https://api.openweathermap.org"
        static let currentWeatherApi = "/data/2.5/weather"
        static let forecastWeatherApi = "/data/2.5/forecast"
        static let units = "metric"
        static let limit = "5"
        static let cityApi = "/geo/1.0/direct"
        static let apiId = "0c9187b255d333ced6a5f14bebf25e82"
    }
}

//поиск города
//https://api.openweathermap.org/geo/1.0/direct?q=London&limit=0&appid=0c9187b255d333ced6a5f14bebf25e82&lang=ru
//поиск на 5 дней
//https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=0c9187b255d333ced6a5f14bebf25e82&q=Alanya
//поиск по координатам на 5 дней
//https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=0c9187b255d333ced6a5f14bebf25e82
//текущая погода
//https://api.openweathermap.org/data/2.5/weather?units=metric&appid=0c9187b255d333ced6a5f14bebf25e82&q=Kyiv&lang=ru
//текущая погода по координатам
//https://api.openweathermap.org/data/2.5/weather?units=metric&appid=0c9187b255d333ced6a5f14bebf25e82&lat=44.34&lon=10.99
