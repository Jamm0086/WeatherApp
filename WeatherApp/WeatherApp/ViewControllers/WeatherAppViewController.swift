//
//  WeatherAppViewController.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/24/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import UIKit
import Alamofire

class WeatherAppViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        WeatherAppViewController.checkInternetConnection()
    }
    
    class func checkInternetConnection(){
        if RestAPIClient.isConnectedToInternet == false {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let noInternetVC = storyboard.instantiateViewController(withIdentifier: "NoInternetConnectionViewController") as! NoInternetConnectionViewController
            UIApplication.shared.windows[0].rootViewController?.present(noInternetVC, animated: true, completion: nil)
        }
    }
}

class WeatherAppTableViewController: UITableViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        WeatherAppViewController.checkInternetConnection()
        
    }
}
