//
//  BootViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 11.01.2023.
//

import UIKit

class StartViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    weak var coordinator: AppCoordinator?
    let viewModel = StartViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        viewModel.locationCallback = { [weak self] location in
            self?.viewModel.getWeatherData(location: location) { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.coordinator?.push(name: .weatherView)
            }
        }
        
        viewModel.errorCallback = { _ in
            self.activityIndicator.stopAnimating()
            self.showAlert(withTitle:"Error", withMessage: "Please enable location services for this app in Settings")

        }
        
        viewModel.startUpdatingLocation()
        
    }
    
}
