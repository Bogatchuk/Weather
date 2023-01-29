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
            let alert = UIAlertController(title: "Error", message: "To display the weather, you need to go to Settings -> Weather-> Allow access to geolocation", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.viewModel.startUpdatingLocation()
            })
            alert.addAction(ok)
            
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }
        
        viewModel.startUpdatingLocation()
        
    }
    
}
