//
//  DateManager.swift
//  Weather
//
//  Created by Roma Bogatchuk on 26.12.2022.
//

import Foundation

class DateService {
  
    static func getStringCurrentDate(timezone: Int?) -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM, HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")
        if let timezone = timezone {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        }
        return dateFormatter.string(from: date)
    }
    
    static func getStringTomorrowDate() -> String{
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: calendar.date(byAdding: .day, value: 1, to: date)!)
    }
    
    static func getDateRelativeToToday(add day: Int, timezone: Int?) -> String{
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: calendar.date(byAdding: .day, value: day, to: date)!)
    }
    
    static func getDateFromString(date: String, timezone: Int?) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "EEEE, d MMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        if timezone != nil {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone!)
        }

        if #available(iOS 15, *) {
            return dateFormatter.string(from: date ?? .now)
        } else {
            return dateFormatter.string(from: date ?? Date())
        }
    }
   
    
    static func getHoure(date: String, timezone: Int?) -> String{
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

// переделать под расширения


//extension Date {
//    func dayOfWeek() -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE"
//        return dateFormatter.string(from: self).capitalized
//    }
//}
