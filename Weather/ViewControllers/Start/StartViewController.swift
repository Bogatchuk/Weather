//
//  BootViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 11.01.2023.
//

import UIKit
import CoreLocation



class StartViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    weak var coordinator: AppCoordinator?
    let locationManager = CLLocationManager()
    let viewModel = StartViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        activityIndicator.startAnimating()
        
    }
    //self.coordinator?.showWeatherView()
    
    
}

extension StartViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locations = locations.last {
            viewModel.getWeatherData(location: locations) { [unowned self] in 
                self.activityIndicator.stopAnimating()
                self.coordinator?.showWeatherView()
            }
           
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            //alert
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied, .restricted:
            // Hide activityIndicator
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            //alert
            break
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            break
        @unknown default:
            // raise an error - This case should never be called
            break
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        //alert
        print(error)
    }
    
}
