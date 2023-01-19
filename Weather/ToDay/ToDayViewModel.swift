//
//  ToDayViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 13.01.2023.
//

import Foundation
import RealmSwift

protocol ToDayViewModelProtocol: AnyObject {
    var date: String {get}
    var feelsLike: String {get}
    var minTemp: String {get}
    var maxTemp: String {get}
    var temperature: String {get}
    var description: String {get}
    var imageName: String {get}
   // init(currentWeather: CurrentWeather, forecastWeather: ForecastWeatherModel)
    func cellViewModel(at indexPath: IndexPath) -> HourCellViewModelProtocol
}

class ToDayViewModel: ToDayViewModelProtocol {
    var imageName: String {
        currentWeather.weather.first?.icon ?? "01d"
    }
    
    var description: String {
        String(describing: currentWeather.weather.first!.descriptionWeather).capitalizingFirstLetter()
    }
    
    var date: String {
        DateManager.shared.getStringCurrentDate(timezone: currentWeather.timezone).capitalized
    }
    var feelsLike: String{
        "feels like \(String(describing: Int(currentWeather.main!.feelsLike)))℃".capitalizingFirstLetter()
    }
    
    var minTemp: String{
        "Min. \(String(describing: Int(currentWeather.main!.tempMin)))℃"
    }
    
    var maxTemp: String{
        "Max. \(String(describing: Int(currentWeather.main!.tempMax)))℃"
    }
    
    var temperature: String{
        "\(String(describing: Int(currentWeather.main!.temp)))℃"
    }
    
    private var currentWeather: CurrentWeather!
    private var forecastWeather: ForecastWeatherModel!
    
    init() {
        guard let currentWeather = StorageManager.shared.getCurrentWeather() else {return}
        guard let forecastWeather = StorageManager.shared.getForecastWeather() else {return}
        self.currentWeather = currentWeather
        self.forecastWeather = forecastWeather
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HourCellViewModelProtocol {
        let hourWeather = forecastWeather.list[indexPath.row]
        let timezone = forecastWeather.city?.timezone
        
        return HourCellViewModel(weatherForTheDay: hourWeather, timezone: timezone!)
    }
}


