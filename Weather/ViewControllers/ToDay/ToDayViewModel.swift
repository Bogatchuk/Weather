//
//  ToDayViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 13.01.2023.
//

import Foundation


protocol ToDayViewModelProtocol: AnyObject {
    var date: String {get}
    var feelsLike: String {get}
    var minTemp: String {get}
    var maxTemp: String {get}
    var temperature: String {get}
    var description: String {get}
    var imageName: String {get}
    func cellViewModel(at indexPath: IndexPath) -> HourCellViewModelProtocol?
    var numberOfRows: Int { get }
}

class ToDayViewModel: ToDayViewModelProtocol {
    
    var numberOfRows: Int {
        8
    }
    
    var imageName: String {
        currentWeather?.weather.first?.icon ?? "01d"
    }
    
    var description: String {
        if let description = currentWeather?.weather.first?.descriptionWeather{
            return String(describing: description).capitalizingFirstLetter()
        } else {
            return " "
        }
    }
    
    var date: String {
        let timezone = currentWeather?.timezone
        return DateService.getStringCurrentDate(timezone: timezone).capitalized
    }
    var feelsLike: String{
        if let feelsLike = currentWeather?.main?.feelsLike{
            return "feels like \(String(describing: Int(feelsLike)))℃".capitalizingFirstLetter()
        } else {
            return " "
        }
    }
    
    var minTemp: String{
        if let min = currentWeather?.main?.tempMin{
            return "Min. \(String(describing: Int(min)))℃"
        } else {
            return " "
        }
    }
    
    var maxTemp: String{
        if let max = currentWeather?.main?.tempMax {
            return "Max. \(String(describing: Int(max)))℃"
        } else {
            return " "
        }
    }
    
    var temperature: String{
        if let temp = currentWeather?.main?.temp{
            return "\(String(describing: Int(temp)))℃"
        } else {
            return " "
        }
    }
    
    private var currentWeather: CurrentWeather?
    private var forecastWeather: ForecastWeatherModel?
    
    init() {
        guard let currentWeather = StorageManager.shared.getCurrentWeather() else {return}
        guard let forecastWeather = StorageManager.shared.getForecastWeather() else {return}
        self.currentWeather = currentWeather
        self.forecastWeather = forecastWeather
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HourCellViewModelProtocol? {
        
        guard let hourWeather = forecastWeather?.list[indexPath.row] else { return  nil }
        guard let timezone = forecastWeather?.city?.timezone else { return nil }
        
        return HourCellViewModel(weatherForTheDay: hourWeather, timezone: timezone)
    }
}


