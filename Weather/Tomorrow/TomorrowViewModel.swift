//
//  TomorrowViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 13.01.2023.
//

import Foundation

protocol TomorrowViewModelProtocol: AnyObject {
    
    var date: String {get}
    var minTemp: String {get}
    var maxTemp: String {get}
    var description: String {get}
    var imageName: String {get}
    func cellViewModel(at indexPath: IndexPath) -> HourCellViewModelProtocol

}

class TomorrowViewModel: TomorrowViewModelProtocol {
    var imageName: String {
        forecastWeather[4].weather.first?.icon ?? "01d"
    }
    
    var description: String {
        String(describing: forecastWeather[5].weather.first!.descriptionWeather).capitalizingFirstLetter()
        
    }
    
    var date: String {
        DateManager.shared.getDateFromString(date: forecastWeather.first?.dt_txt ?? "nil", timezone: nil).capitalized
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

    
    private var timezone: Int!
    private var forecastWeather = [WeatherLists]()
    
    init() {
        guard let forecastWeather = StorageManager.shared.getForecastWeather() else {return}
        self.timezone = forecastWeather.city!.timezone!
        
        for list in Array(forecastWeather.list) {
            self.forecastWeather.append(list)
        }
        self.forecastWeather = self.forecastWeather.filter({ list in
            DateManager.shared.getDateFromString(date: list.dt_txt, timezone: (forecastWeather.city?.timezone)!) == DateManager.shared.getStringTomorrowDate()
        })
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HourCellViewModelProtocol {
        
        let weatherForTomorrow = forecastWeather[indexPath.row]       
        return HourCellViewModel(weatherForTheDay: weatherForTomorrow, timezone: timezone)
    }
    
}
