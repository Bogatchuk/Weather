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

// MARK: - WeatherModel
class ForecastWeatherModel: Object, Codable {
    @Persisted var list = List<WeatherLists>()
    @Persisted var city: City?
}


