//
//  StorageManager.swift
//  Weather
//
//  Created by Roma Bogatchuk on 16.01.2023.
//

import Foundation
import RealmSwift

enum StorageError: Error {
    case failedToSave
    case failedToDelete
}


class StorageManager {
    private init(){}
    static let shared = StorageManager()
    
    let realm: Realm? = try? Realm()
    
    // Save city to search list
    func saveCityToSearch(city: CitySearch){
        
        guard let listOfCities = realm?.objects(CitySearch.self) else { return }
        
        for cityFromList in listOfCities {
            if cityFromList.city == city.city {
                try? realm?.write {
                    realm?.delete(cityFromList)
                }
            }
        }
        
        try? realm?.write {
            realm?.add(city)
        }
        
    }
    
    func saveForecastWeather(forecastWeather: ForecastWeatherModel){
        
        try? realm?.write {
            realm?.deleteAll(ForecastWeatherModel.self)
            realm?.add(forecastWeather)
        }
    }
    
    func saveCurrentWeather(currentWeather: CurrentWeather){
        try? realm?.write {
            realm?.deleteAll(CurrentWeather.self)
            realm?.add(currentWeather)
        }
    }
    
    func delete(_ city: CitySearch) throws {
        do {
            try realm?.write{
                realm?.delete(city)
            }
        } catch {
            throw StorageError.failedToDelete
        }
    }
    
    func getForecastWeather() -> ForecastWeatherModel?{
        return realm?.objects(ForecastWeatherModel.self).first
    }
    
    func getCurrentWeather() -> CurrentWeather?{
        return realm?.objects(CurrentWeather.self).first
    }
    
    func getListCities() -> [CitySearch]?{
        
        if let cities = realm?.objects(CitySearch.self) {
            return Array(cities)
        }else {
            return nil
        }
    }
    
}


