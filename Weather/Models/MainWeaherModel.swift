//
//  File.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.01.2023.
//

import RealmSwift

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
