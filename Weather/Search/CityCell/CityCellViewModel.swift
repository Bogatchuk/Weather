//
//  CityCellViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 15.01.2023.
//

import Foundation

protocol CityCellViewModelProtocol{
    var city: String { get }
    var region: String { get }
    var country: String { get }
    init(foundCity: CitySearch)
    
}

class CityCellViewModel: CityCellViewModelProtocol {
    var city: String {
        foundCity?.city ?? "City"
    }
    
    var region: String {
        foundCity.region 
    }
    
    var country: String {
        foundCity.country
    }
    
    private let foundCity: CitySearch!
    required init(foundCity: CitySearch) {
        self.foundCity = foundCity
    }
    
    
}
