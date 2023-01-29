//
//  DayCellViewModel.swift
//  Weather
//
//  Created by Roma Bogatchuk on 14.01.2023.
//

import Foundation

protocol DayCellViewModelProtocol: AnyObject {
    var date: String { get }
    var description: String { get }
    var minTemp: String { get }
    var maxTemp: String { get }
    var imageName: String { get }
    init(weatherForTheDay: [WeatherLists])
}

class DayCellViewModel: DayCellViewModelProtocol {
   
    
    var date: String {
        DateService.getDateFromString(date: weatherForTheDay.first?.dt_txt ?? "Date", timezone: nil).capitalized
    }
     
    var description: String {
        if weatherForTheDay.count != Constants.fullDay {
            
            return String(describing: weatherForTheDay.first?.weather.first!.descriptionWeather ?? "").capitalizingFirstLetter()
        }else{
           
            return  String(describing: weatherForTheDay[Constants.middayIndex].weather.first!.descriptionWeather ?? "").capitalizingFirstLetter()
        }
    }
    
    var minTemp: String {
        let min = weatherForTheDay.reduce(Int.max){ result, x in
            return result < Int(x.main!.tempMin) ? result : Int(x.main!.tempMin)
        }
        return "\(String(describing: min)) ℃"
    }
    
    var maxTemp: String{
        let max = weatherForTheDay.reduce(Int.min){ result, x in
            return result > Int(x.main!.tempMax) ? result : Int(x.main!.tempMax)
        }

        return "\(String(describing: max)) ℃"
    }
    
    var imageName: String {
        print(weatherForTheDay.count )
        if weatherForTheDay.count != Constants.fullDay  {
            return weatherForTheDay.first?.weather.first!.icon ?? "01d"
        }else{
            return weatherForTheDay[Constants.middayIndex].weather.first!.icon ?? "01d"
        }
    }
    
    private var weatherForTheDay: [WeatherLists]
    
    required init(weatherForTheDay: [WeatherLists]) {
        self.weatherForTheDay = weatherForTheDay
    }
    
}
