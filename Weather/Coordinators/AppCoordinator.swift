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
        let vc = UIStoryboard(name: "Start", bundle: nil).instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showWeatherView(){
        let vc = UIStoryboard(name: "Weather", bundle: nil)
            .instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        vc.coordinator = self
        
        //navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showSearchView(){
        let vc = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.coordinator = self
      //  navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc, animated: true)
        
    }
}
