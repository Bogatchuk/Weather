//
//  DataFetcherService.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.12.2022.
//

import Foundation

class DataFetcherService {
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=0c9187b255d333ced6a5f14bebf25e82"
    private let forecastWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=0c9187b255d333ced6a5f14bebf25e82"
    private let featchCityURL = "https://api.openweathermap.org/geo/1.0/direct?limit=0&appid=0c9187b255d333ced6a5f14bebf25e82"
    func fetchCurrentWeather(city: String, completion: @escaping (CurrentWeather?) -> ()){
        let urlString = "\(weatherURL)&q=\(city)"
        NetworkDataFetcher.shared.fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> ()){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        NetworkDataFetcher.shared.fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchForecastWeather(city: String, completion: @escaping (ForecastWeatherModel?) -> ()){
        let urlString = "\(forecastWeatherURL)&q=\(city)"
        NetworkDataFetcher.shared.fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchForecastWeather(latitude: Double, longitude: Double, completion: @escaping (ForecastWeatherModel?) -> ()){
        let urlString = "\(forecastWeatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        NetworkDataFetcher.shared.fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func featchCity(city: String, completion: @escaping (FoundCity?) -> ()){
        let urlString = "\(featchCityURL)&q=\(city)"
        NetworkDataFetcher.shared.fetchGenericJSONData(urlString: urlString, completion: completion)
    }
}

//поиск города
//https://api.openweathermap.org/geo/1.0/direct?q=London&limit=0&appid=0c9187b255d333ced6a5f14bebf25e82
//поиск на 5 дней
//https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=0c9187b255d333ced6a5f14bebf25e82&q=Alanya
//поиск по координатам на 5 дней
//https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=0c9187b255d333ced6a5f14bebf25e82
//текущая погода
//https://api.openweathermap.org/data/2.5/weather?units=metric&appid=0c9187b255d333ced6a5f14bebf25e82&q=Kyiv
//текущая погода по координатам
//https://api.openweathermap.org/data/2.5/weather?units=metric&appid=0c9187b255d333ced6a5f14bebf25e82&lat=44.34&lon=10.99


