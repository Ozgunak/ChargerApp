//
//  SplashViewController.swift
//  Charger
//
//  Created by ozgun on 2.07.2022.
//

import UIKit
import CoreLocation

class SplashViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    let router = Router()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        locationManager.startUpdatingLocation()
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "charcoalGrey")


        router.routeToLogin(from: self.navigationController!)
    }
    


}
extension SplashViewController: CLLocationManagerDelegate {
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            User.location.latitude = lat
            User.location.longditude = lon
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
