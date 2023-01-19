//
//  StorageManager.swift
//  Weather
//
//  Created by Roma Bogatchuk on 16.01.2023.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    private init(){}
    static let shared = StorageManager()
    
    func saveCityToSearch(city: CitySearch){
        
        let listOfCities = realm.objects(CitySearch.self)
        
        for cityFromList in listOfCities {
            if cityFromList.city == city.city {
                try! realm.write {
                    realm.delete(cityFromList)
                }
            }
        }
        
        try! realm.write {
            realm.add(city)
        }
        
    }
    
    func saveForecastWeather(forecastWeather: ForecastWeatherModel){

        try! realm.write {
            realm.deleteAll(ForecastWeatherModel.self)
            realm.add(forecastWeather)
        }
    }
    
    func saveCurrentWeather(currentWeather: CurrentWeather){
        try! realm.write {
            realm.deleteAll(CurrentWeather.self)
            realm.add(currentWeather)
        }
    }
    
    func delete(_ city: CitySearch){
        try! realm.write{
            realm.delete(city)
        }
    }
    
    func getForecastWeather() -> ForecastWeatherModel?{
        return realm.objects(ForecastWeatherModel.self).first
    }
    
    func getCurrentWeather() -> CurrentWeather?{
        return realm.objects(CurrentWeather.self).first
    }
    
    func getListCities() -> [CitySearch]?{
        let result = Array(realm.objects(CitySearch.self))
        return result
    }
    
}

extension Realm {
    
    func deleteAll<T: Object>(_ type: T.Type) {
        delete(objects(T.self))
    }
}
