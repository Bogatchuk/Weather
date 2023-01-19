//
//  WeatherModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 18.12.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import RealmSwift

typealias FoundCity = [City]

// MARK: - WeatherModel
class ForecastWeatherModel: Object, Codable {
    @Persisted var list = List<WeatherLists>()
    @Persisted var city: City?
}


class WeatherLists: Object, Codable {
    @Persisted var main: Main?
    @Persisted var weather: List<Weather>
    @Persisted var dt_txt: String
}

// MARK: - City
class City: Object,  Codable {
    @Persisted var name: String
    @Persisted var coord: Coord?
    @Persisted var country: String
    @Persisted var state: String?
    @Persisted var timezone: Int?
}

// MARK: - Coord
class Coord: Object, Codable {
    @Persisted var lon: Double
    @Persisted var lat: Double
}
// MARK: - Main
class Main: Object, Codable {
    @Persisted var temp: Double
    @Persisted var feelsLike: Double
    @Persisted var tempMin: Double
    @Persisted var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        
    }
}

// MARK: - Weather
class Weather: Object, Codable {
    @Persisted var descriptionWeather: String
    @Persisted var icon: String
    @Persisted var main: String
    
    enum CodingKeys: String, CodingKey {
        case descriptionWeather = "description"
        case icon
        case main
    }
}

