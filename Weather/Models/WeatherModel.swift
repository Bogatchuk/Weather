//
//  WeatherModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.01.2023.
//

import RealmSwift

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
