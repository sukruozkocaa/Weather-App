//
//  Extensions.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 19.01.2024.
//

import Foundation
import UIKit

extension String {
    func capitalizeFirstLetter(_ input: String) -> String {
        guard let firstLetter = input.first else {
            return input
        }
        
        return String(firstLetter).capitalized + String(input.dropFirst())
    }
    
    func kelvinToCelcius(temp: Double) -> Int {
        return Int(temp - 273.15)
    }
    
    func celciusToKelvin(temp: Double) -> Int {
        return Int(temp + 273.15)
    }
}

extension UICollectionView {
    var visibleCurrentCellIndexPath: IndexPath? {
        for cell in self.visibleCells {
            let indexPath = self.indexPath(for: cell)
            return indexPath
        }
        return nil
    }
}

extension UserDefaults {
    enum Keys {
        static let weatherValueTypes = "WeatherValueTypes"
    }
}
