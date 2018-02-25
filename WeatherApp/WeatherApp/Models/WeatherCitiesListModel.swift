//
//  WeatherCitiesListModel.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/23/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import Foundation
import CoreLocation

public protocol WeatherCitiesListModelDelegate: class {
    func updateCompleted()
}

class WeatherCitiesListModel: NSObject, CoreLocationManagerDelegate {
    
    private static let findCitiesMethod = "find"
    private static let latitudeKey = "lat"
    private static let longitudeKey = "lon"
    private static let countKey = "cnt"
    
    weak var delegate: WeatherCitiesListModelDelegate!
    
    var apiClient: RestAPIClient
    
    var citiesList: [WeatherCityModel]?
    
    let locationManager = CoreLocationManager.sharedInstance
    
    override init(){
        apiClient = RestAPIClient(serverBaseURL: Constants.baseURLString)
        super.init()
        locationManager.delegate = self
    }
    
    func loadCities() {
        requestCities()
    }
    
    func loadCitiesAndUpdateLocation() {
        locationManager.updateLocation()
    }
    
    func requestCities() {
        if RestAPIClient.isConnectedToInternet {
            guard let lat = locationManager.localLatitud, let long = locationManager.localLongitude else {
                return
            }
            
            let body: Dictionary = [WeatherCitiesListModel.latitudeKey: lat,
                                    WeatherCitiesListModel.longitudeKey: long,
                                    WeatherCitiesListModel.countKey: "10",
                                    Constants.openWeatherAPIKKey: Constants.openWeatherAPIKey] as [String : Any]
            
            self.apiClient.request(verb: "get", method: WeatherCitiesListModel.findCitiesMethod, body: body) { (error, data) in
                if error == nil && data != nil {
                    self.deserializeList(JsonData: data as! [String : Any])
                    if self.delegate != nil {
                        self.delegate.updateCompleted()
                    }
                }
            }
        }
    }
    
    func updateLocationCompleted() {
        requestCities()
    }
    
    func deserializeList(JsonData json: [String: Any]) {
        
        let list = json["list"] as! [[String: Any]]
        if citiesList != nil {
            citiesList = nil
        } 
        citiesList = Array()
        for jsonCity in list {
            let city = WeatherCityModel(jsonData: jsonCity)
            citiesList?.append(city)
        }
        
    }
    
}
