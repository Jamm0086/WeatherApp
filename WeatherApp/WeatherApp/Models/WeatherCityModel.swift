//
//  WeatherCityModel.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/23/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherCityModel: NSObject {
    
    enum Weather: String {
        case sunny
        case rainy
        case windy
        case clouds
    }
    
    let name: String
    let tempMax: Double
    let tempMin: Double
    let temp: Double
    let pressure: Double
    let coordinates: CLLocationCoordinate2D
    let humidity: Double
    let windSpeed: Double
    var weatherSet: Set<Weather>?
    var weatherImage: UIImage?
    var weatherDescription: String?
    
    init (jsonData json: [String: Any]) {
        name = (json["name"] as? String)!
        let mainConditions = json["main"] as! [String: Any]
        tempMax = mainConditions["temp_max"] as! Double
        tempMin = mainConditions["temp_min"] as! Double
        temp = mainConditions["temp"] as! Double
        pressure = mainConditions["pressure"] as! Double
        humidity = mainConditions["humidity"] as! Double
        let coord = json["coord"] as! [String: Any]
        coordinates = CLLocationCoordinate2DMake(coord["lat"] as! Double, coord["lon"] as! Double)
        let windConditions = json["wind"] as! [String: Any]
        windSpeed = windConditions["speed"] as! Double
        super.init()
        
        self .deserializeWeather(jsonData: json["weather"] as! [Any])
        self.setWeatherImage()
    }
    
    func deserializeWeather(jsonData json: [Any]) {
        weatherSet = []
        for weatherDic in json {
            if let dic = weatherDic as? [String: Any] {
                let id = dic["id"] as! Int
                
                switch id {
                case 200...232:
                    weatherSet?.insert(.rainy)
                case 300...321:
                    weatherSet?.insert(.rainy)
                case 500...504:
                    weatherSet?.insert(.sunny)
                    weatherSet?.insert(.rainy)
                case 520...531:
                    weatherSet?.insert(.rainy)
                    weatherSet?.insert(.windy)
                case 701...781:
                    weatherSet?.insert(.windy)
                case 800, 904:
                    weatherSet?.insert(.sunny)
                case 801...804:
                    weatherSet?.insert(.clouds)
                case 905:
                    weatherSet?.insert(.windy)
                default:
                    weatherSet?.insert(.sunny)
                    break
                }
                let description = dic["main"] as! String
                if let _ = weatherDescription {
                    weatherDescription?.append(" • \(description) ")
                } else {
                    weatherDescription = description
                }
            }
        }
    }
    
    
    func setWeatherImage () {
        if let weathers = weatherSet {
            if weathers.count == 1 {
                if weathers.contains(.sunny) {
                    weatherImage = #imageLiteral(resourceName: "sunnyImage")
                } else if weathers.contains(.rainy) {
                    weatherImage = #imageLiteral(resourceName: "rainyImage")
                } else if weathers.contains(.windy) {
                    weatherImage = #imageLiteral(resourceName: "windyImage")
                } else if weathers.contains(.clouds) {
                    weatherImage = #imageLiteral(resourceName: "sunCloudyImage")
                }
            } else if weathers.count == 2 {
                if weathers.contains(.sunny) && weathers.contains(.rainy) {
                    weatherImage = #imageLiteral(resourceName: "sunRainyImage")
                } else if weathers.contains(.windy) && weathers.contains(.rainy) {
                    weatherImage = #imageLiteral(resourceName: "windyRainyImage")
                }
            } else if weathers.count >= 3 {
                weatherImage = #imageLiteral(resourceName: "sunCloudyWindImage")
            }
        }
    }
}

extension WeatherCityModel {
    
    func convertKelvinToCelsius(kelvin: Double) -> Double {
        return Double(kelvin - 273.15).rounded()
    }
    
    func convertyKelvinToCelsiusDegreeString(kelvin: Double) -> String {
        let celsius = Double(kelvin - 273.15).rounded()
        return String (format: "%.0fº", celsius)
    }
    
    func convertyKelvinToCelsiusString(kelvin: Double) -> String {
        let celsius = Double(kelvin - 273.15).rounded()
        return String (format: "%.0f", celsius)
    }
    
    func convertHectoPascaltoATMString(hpa: Double) -> String {
        let atm = Double(hpa * 0.00098692326671601)
        return String(format: "%1.f", atm)
    }
}
