//
//  LocationService.swift
//  Weather
//
//  Created by Roma Bogatchuk on 28.01.2023.
//

import CoreLocation


class LocationService: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager
    var locationCallback: ((CLLocation?) -> Void)?
    var errorCallback: ((Error) -> Void)?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
    }
    
    
    func startUpdatingLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationCallback?(location)
        } else {
            locationCallback?(nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied, .restricted:
            errorCallback?(NSError(domain: "Location services are disabled", code: 0, userInfo: nil))
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            errorCallback?(NSError(domain: "Location services are disabled", code: 0, userInfo: nil))
            break
        @unknown default:
            // raise an error - This case should never be called
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorCallback?(error)
    }
}




