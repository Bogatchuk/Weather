//
//  City.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.01.2023.
//

import RealmSwift

typealias FoundCity = [City]

// MARK: - City
class City: Object,  Codable {
    @Persisted var name: String
    @Persisted var coord: Coord?
    @Persisted var country: String
    @Persisted var state: String?
    @Persisted var timezone: Int?
}
