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
        
        viewModel.locationCallback = { [unowned self] location in
            self.viewModel.getWeatherData(location: location) { [unowned self] in
                self.activityIndicator.stopAnimating()
                self.coordinator?.push(name: .weatherView)
            }
        }
        viewModel.startUpdatingLocation()
        
    }

}
