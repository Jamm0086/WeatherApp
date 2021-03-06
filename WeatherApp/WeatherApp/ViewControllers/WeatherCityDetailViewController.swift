//
//  WeatherCityDetailViewController.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/23/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import UIKit

class WeatherCityDetailViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var bigTempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var medTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var humLabel: UILabel!
    @IBOutlet weak var atmLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    var weatherCity: WeatherCityModel!
    
    override func viewDidLoad() {
        if let city = weatherCity {
            navigationBarTextStyle(title: city.name)
            prepareView()
        }
    }
    
    func prepareView(){
         if let city = weatherCity {
            
            weatherImage.image = city.weatherImage
            bigTempLabel.text = city.convertyKelvinToCelsiusDegreeString(kelvin: city.temp)
            weatherDescriptionLabel.text = city.weatherDescription!
            
            let minTemp = city.convertyKelvinToCelsiusString(kelvin: city.tempMin)
            minTempLabel.attributedText = NSMutableAttributedString.detailDegreesFormatter(degrees: minTemp, title: "MIN")
            let medtemp = city.convertyKelvinToCelsiusString(kelvin: city.temp)
            medTempLabel.attributedText = NSMutableAttributedString.detailDegreesFormatter(degrees: medtemp, title: "MED")
            let maxTemp = city.convertyKelvinToCelsiusString(kelvin: city.tempMax)
            maxTempLabel.attributedText = NSMutableAttributedString.detailDegreesFormatter(degrees: maxTemp, title: "MAX")
            
            let hum = String(format:"%.0f", city.humidity)
            humLabel.attributedText = NSMutableAttributedString.detailPercentageFormatter(percentage: hum, title: "Hum")
            let atm = city.convertHectoPascaltoATMString(hpa: city.pressure)
            atmLabel.attributedText = NSMutableAttributedString.detailFormatter(number: atm, title: "Atm")
            let wind = String(format:"%.1f", city.windSpeed)
            windLabel.attributedText = NSMutableAttributedString.detailFormatter(number: wind, title: "km/m")
            
        }
    }
    
}
