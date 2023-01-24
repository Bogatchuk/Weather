//
//  Location.swift
//  Weather
//
//  Created by Roma Bogatchuk on 18.12.2022.
//

import RealmSwift

struct Location: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}

// MARK: - Coord
class Coord: Object, Codable {
    @Persisted var lon: Double
    @Persisted var lat: Double
}
