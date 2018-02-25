//
//  AttributedStringExtension.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/24/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    func detailDegreesFormatter(degrees: String, title: String) -> NSMutableAttributedString {
        let text = "\(degrees)º\n\(title)"
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont(name: "Arvo", size: 14.0)!,
            .foregroundColor: UIColor(white: 74.0 / 255.0, alpha: 1.0)
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "Arvo", size: 24.0)!, range: NSRange(location: 0, length: 2))
        attributedString.addAttribute(.font, value: UIFont(name: "ArialMT", size: 24.0)!, range: NSRange(location: 2, length: 1))
        
        return attributedString
    }
    
    func detailPercentageFormatter(percentage: String, title: String) -> NSMutableAttributedString {
        let text = "\(percentage)%\n\(title)"
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont(name: "Arvo", size: 14.0)!,
            .foregroundColor: UIColor(white: 74.0 / 255.0, alpha: 1.0)
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "Arvo", size: 24.0)!, range: NSRange(location: 0, length: 2))
        
        return attributedString
    }
    
    func detailFormatter(number: String, title: String)-> NSMutableAttributedString {
        let text = "\(number)\n\(title)"
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont(name: "Arvo", size: 13.0)!,
            .foregroundColor: UIColor(white: 74.0 / 255.0, alpha: 1.0)
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "Arvo", size: 24.0)!, range: NSRange(location: 0, length: number.count))
        
        return attributedString
    }
    
}
