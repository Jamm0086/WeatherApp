//
//  UIViewControllerExtension.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/24/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarTextStyle() {
        if let navController = self.navigationController {
            let navigationTitleFont = UIFont(name: "Arvo", size: 22)!
            navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: navigationTitleFont, NSAttributedStringKey.foregroundColor: UIColor.waterBlue]
        }
    }
    
    func setNavigationBarDetailTextStyle(title text: String) {
        if let navController = self.navigationController {
            let navigationTitleFont = UIFont(name: "Arvo", size: 22)!
            navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: navigationTitleFont, NSAttributedStringKey.foregroundColor: UIColor.detailTitleColor]
            self.title = text
            if let backItem = navController.navigationBar.topItem {
                backItem.title = " "
            }
        }
    }
    
}
