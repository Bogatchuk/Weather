//
//  TomorrowViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 13.01.2023.
//

import Foundation

protocol TomorrowViewModelProtocol: AnyObject {
    
    var date: String { get }
    var minTemp: String { get }
    var maxTemp: String { get }
    var description: String { get }
    var imageName: String { get }
    var numberOfRows: Int { get }
    func cellViewModel(at indexPath: IndexPath) -> HourCellViewModelProtocol
    
    
}

class TomorrowViewModel: TomorrowViewModelProtocol {
    private let middayIndex = 4
    
    var imageName: String {
        if forecastWeather.count > middayIndex {
            return forecastWeather[middayIndex].weather.first?.icon ?? "01d"
        } else {
            return "01d"
        }
    }
    
    var description: String {
        if forecastWeather.count > middayIndex {
            return String(describing: forecastWeather[middayIndex].weather.first!.descriptionWeather)
                .capitalizingFirstLetter()
        } else {
            return "01d"
        }
        
    }
    
    var date: String {
        DateService.getDateFromString(date: forecastWeather.first?.dt_txt ?? "nil", timezone: nil).capitalized
    }
    
    var minTemp: String{
        let min = forecastWeather.reduce(Int.max){ result, x in
            if result < Int(x.main!.tempMin) {
                return result
            } else {
                return Int(x.main!.tempMin)
            }
            
        }
        return "Min. \(String(describing: Int(min)))℃"
    }
    
    var maxTemp: String{
        let max = forecastWeather.reduce(Int.min){ result, x in
            if result > Int(x.main!.tempMax) {
                return result
            } else {
                return Int(x.main!.tempMax)
            }
            
        }
        return "Max. \(String(describing: Int(max)))℃"
    }
    
    var numberOfRows: Int {
        forecastWeather.count
    }
    
    private var timezone: Int?
    private var forecastWeather = [WeatherLists]()
    
    init() {
        guard let forecastWeather = StorageManager.shared.getForecastWeather() else {return}
        if let timezone = forecastWeather.city?.timezone {
            self.timezone = timezone
        } else {
            timezone = 0
        }
        
        for list in Array(forecastWeather.list) {
            self.forecastWeather.append(list)
        }
        self.forecastWeather = self.forecastWeather.filter({ list in
            DateService.getDateFromString(date: list.dt_txt, timezone: (forecastWeather.city?.timezone)!) == DateService.getStringTomorrowDate()
        })
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HourCellViewModelProtocol {
        
        let weatherForTomorrow = forecastWeather[indexPath.row]
        return HourCellViewModel(weatherForTheDay: weatherForTomorrow, timezone: timezone)
    }
    
}
