//
//  AppCoordinator.swift
//  Weather
//
//  Created by Roma Bogatchuk on 22.01.2023.
//

import UIKit

class AppCoordinator: Coordinator{
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = EnumScreens.startView.viewController as! StartViewController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    
    func push(name: EnumScreens){
        switch name{
        case .startView:
            let vc = EnumScreens.startView.viewController as! StartViewController
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        case .weatherView:
            let vc = EnumScreens.weatherView.viewController as! MainViewController
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        case .searchView:
            let vc = EnumScreens.searchView.viewController as! SearchViewController
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}




