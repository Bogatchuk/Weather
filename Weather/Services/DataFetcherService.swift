//
//  DataFetcherService.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.12.2022.
//

import Foundation

class DataFetcherService {

    func fetchCurrentWeather(city: String, completion: @escaping (CurrentWeather?) -> ()){
        
        var components = URLComponents(string: Constants.baseApiUrl)
        components?.path = Constants.currentWeatherApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.units),
            URLQueryItem(name: "appid", value: Constants.apiId),
            URLQueryItem(name: "q", value: city)
        ]
        
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
    
    func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> ()){
        
        var components = URLComponents(string: Constants.baseApiUrl)
        components?.path = Constants.currentWeatherApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.units),
            URLQueryItem(name: "appid", value: Constants.apiId),
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude))
            
        ]
        
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
    
    func fetchForecastWeather(city: String, completion: @escaping (ForecastWeatherModel?) -> ()){
        
        var components = URLComponents(string: Constants.baseApiUrl)
        components?.path = Constants.forecastWeatherApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.units),
            URLQueryItem(name: "appid", value: Constants.apiId),
            URLQueryItem(name: "q", value: city)
        ]
        
        
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
    
    func fetchForecastWeather(latitude: Double, longitude: Double, completion: @escaping (ForecastWeatherModel?) -> ()){
        
        var components = URLComponents(string: Constants.baseApiUrl)
        components?.path = Constants.forecastWeatherApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.units),
            URLQueryItem(name: "appid", value: Constants.apiId),
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude))
            
        ]
        
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
    
    func featchCity(city: String, completion: @escaping (FoundCity?) -> ()){
          
        var components = URLComponents(string: Constants.baseApiUrl)
        components?.path = Constants.cityApi
        components?.queryItems = [
            URLQueryItem(name: "units", value: Constants.units),
            URLQueryItem(name: "appid", value: Constants.apiId),
            URLQueryItem(name: "q", value: city)
        ]
        guard let url = components?.url else {return}
        NetworkDataFetcher.shared.fetchGenericJSONData(url: url, completion: completion)
    }
}



