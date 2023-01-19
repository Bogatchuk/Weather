//
//  DateManager.swift
//  Weather
//
//  Created by Roma Bogatchuk on 26.12.2022.
//

import Foundation

class DateManager {
    static let shared = DateManager ()
    private init(){}
  
    func getStringCurrentDate(timezone: Int) -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM, HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return dateFormatter.string(from: date)
    }
    
    func getStringTomorrowDate() -> String{
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: calendar.date(byAdding: .day, value: 1, to: date)!)
    }
    
    func getDateRelativeToToday(add day: Int) -> String{
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: calendar.date(byAdding: .day, value: day, to: date)!)
    }
    
    func getDateFromString(date: String, timezone: Int?) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "EEEE, d MMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        if timezone != nil {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone!)
        }

        return dateFormatter.string(from: date ?? .now)
    }
   
    
    func getHoure(date: String, timezone: Int?) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm"
        if timezone != nil {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone!)
        }
        return dateFormatter.string(from: date!)
    }
 
}
