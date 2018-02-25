//
//  CoreLocationManager.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/23/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import UIKit
import CoreLocation

public protocol CoreLocationManagerDelegate: class {
    func updateLocationCompleted()
}

class CoreLocationManager : NSObject, CLLocationManagerDelegate {
    // Singleton Instance
    static let sharedInstance = CoreLocationManager()
    // Delegate
    weak var delegate: CoreLocationManagerDelegate!
    
    let locationManager = CLLocationManager()
    
    var localLatitud: CLLocationDegrees?
    var localLongitude: CLLocationDegrees?
    
    override init() {
        
        super.init()
        updateLocation()
    }
    
    func updateLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse  || status == .authorizedAlways {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        } else {
            requestAuthorization(status: status)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("location - Latitude: \(locValue.latitude) and Longitude \(locValue.longitude)")
        localLatitud = locValue.latitude
        localLongitude = locValue.longitude
        
        if (delegate != nil) {
            delegate.updateLocationCompleted()
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        requestAuthorization(status: status)
    }
    
    func requestAuthorization(status: CLAuthorizationStatus){
        if status == .notDetermined || status == .denied {
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error!", message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settigs app under Privacy, Location Services.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Go to Settings now", style: .default, handler: { (alert: UIAlertAction!) in
                    let url = URL(string: UIApplicationOpenSettingsURLString)
                    UIApplication.shared.open( url!, options: [:], completionHandler: { (success) in
                        print("Open url : \(success)")
                    })
                })
                alert.addAction(alertAction)
                UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}
