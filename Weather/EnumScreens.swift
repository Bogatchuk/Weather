//
//  EnumScreanName.swift
//  Weather
//
//  Created by Roma Bogatchuk on 27.01.2023.
//

import UIKit

enum EnumScreens: String {
    case startView = "Start"
    case weatherView = "Weather"
    case searchView = "Search"
    case toDayView = "ToDay"
    case tomorrowView = "Tomorrow"
    case fiveDaysView = "FiveDays"
    
    var viewController: UIViewController {
            switch self {
            case .startView:
                return StartViewController.instantiate(name: self.rawValue)
            case .weatherView:
                return MainViewController.instantiate(name: self.rawValue)
            case .searchView:
                return SearchViewController.instantiate(name: self.rawValue)
            case .toDayView:
                return ToDayViewController.instantiate(name: self.rawValue)
            case .tomorrowView:
                return TomorrowViewController.instantiate(name: self.rawValue)
            case .fiveDaysView:
                return FiveDaysViewController.instantiate(name: self.rawValue)
            }
        }
}
