//
//  Location.swift
//  Weather
//
//  Created by Roma Bogatchuk on 18.12.2022.
//

import Foundation

struct Location: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}
