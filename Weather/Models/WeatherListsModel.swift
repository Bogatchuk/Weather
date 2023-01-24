//
//  File.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.01.2023.
//


import RealmSwift

class WeatherLists: Object, Codable {
    @Persisted var main: Main?
    @Persisted var weather: List<Weather>
    @Persisted var dt_txt: String
}
