//
//  DataFetcherService.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.12.2022.
//

import Foundation

class DataFetcherService {

   static func fetchCurrentWeather(city: String, completion: @escaping (CurrentWeather?) -> ()){
        
       var components = URLComponents(string: Constants.WeatherURL.baseApiUrl)
       components?.path = Constants.WeatherURL.currentWeatherApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.WeatherURL.units),
            URLQueryItem(name: "appid", value: Constants.WeatherURL.apiId),
            URLQueryItem(name: "q", value: city)
        ]
        
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
    
    static func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> ()){
        
        var components = URLComponents(string: Constants.WeatherURL.baseApiUrl)
        components?.path = Constants.WeatherURL.currentWeatherApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.WeatherURL.units),
            URLQueryItem(name: "appid", value: Constants.WeatherURL.apiId),
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude))
            
        ]
        
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
    
    static func fetchForecastWeather(city: String, completion: @escaping (ForecastWeatherModel?) -> ()){
        
        var components = URLComponents(string: Constants.WeatherURL.baseApiUrl)
        components?.path = Constants.WeatherURL.forecastWeatherApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.WeatherURL.units),
            URLQueryItem(name: "appid", value: Constants.WeatherURL.apiId),
            URLQueryItem(name: "q", value: city)
        ]
        
        
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
    
    static func fetchForecastWeather(latitude: Double, longitude: Double, completion: @escaping (ForecastWeatherModel?) -> ()){
        
        var components = URLComponents(string: Constants.WeatherURL.baseApiUrl)
        components?.path = Constants.WeatherURL.forecastWeatherApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.WeatherURL.units),
            URLQueryItem(name: "appid", value: Constants.WeatherURL.apiId),
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude))
            
        ]
        
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
    
    static func featchCity(city: String, completion: @escaping (FoundCity?) -> ()){
          
        var components = URLComponents(string: Constants.WeatherURL.baseApiUrl)
        components?.path = Constants.WeatherURL.cityApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.WeatherURL.units),
            URLQueryItem(name: "appid", value: Constants.WeatherURL.apiId),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "limit", value: Constants.WeatherURL.limit)
        ]
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
}



