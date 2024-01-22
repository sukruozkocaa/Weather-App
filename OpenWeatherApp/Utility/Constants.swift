//
//  Constants.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 18.01.2024.
//

import Foundation
import UIKit

class Constants: NSObject {
    static let shared = Constants()

    // API KEY
    let API_KEY = "9a008ed65298613b6ede0f9f7d586eec"

    // Current Weather URL
    let baseURL = "https://api.openweathermap.org/data/2.5"
    
    // Weather status icon base URL
    let iconBaseURL = "https://openweathermap.org/img/wn/"
    
    // Current location weather URL
    let currentWeatherURL = "/weather?"
    
    // Long forecast weather URL
    let forecastWeatherURL = "/forecast?"
    
    // Segmented Control Tint Color
    let segmentedTintColor: UIColor = .gray
    
    // Segmented Selected Color
    let segmentedSelectedColor: UIColor = .white
    
    // Weather Forecase Cell Identifier
    let WeatherForecastItemCell = "WeatherForecastItemCell"
    
    // Weather Detail  Cell Identifier
    let weatherDetailItemCell = "WeatherDetailItemCell"
    
}
