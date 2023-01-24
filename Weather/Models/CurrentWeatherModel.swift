//
//  CurrentWeather.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.12.2022.
//

import Foundation
import RealmSwift

// MARK: - WeatherModel
class CurrentWeather: Object, Decodable {
    @Persisted var coord: Coord?
    @Persisted var weather: List<Weather>
    @Persisted var main: Main?
    @Persisted var name: String
    @Persisted var timezone: Int
}


