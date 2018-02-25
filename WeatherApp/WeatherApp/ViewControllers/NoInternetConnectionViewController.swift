//
//  NoInternetConnectionViewController.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/24/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import UIKit

class NoInternetConnectionViewController: UIViewController {
    
    @IBOutlet weak var retryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retryButton.backgroundColor = UIColor.waterBlue
    }
    
    // MARK: - IBActions
    
    @IBAction func retryAction(_ sender: Any) {
        if RestAPIClient.isConnectedToInternet {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
