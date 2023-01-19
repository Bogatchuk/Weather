//
//  CitiesList.swift
//  Weather
//
//  Created by Roma Bogatchuk on 16.01.2023.
//

import RealmSwift

class CitySearch: Object {
    
    @Persisted var city: String
    @Persisted var region: String
    @Persisted var country: String

    
    convenience init(city: City) {
        self.init()
        self.city = city.name
        self.region = city.state ?? ""
        self.country = city.country
       
    }
}


