//
//  WeatherViewModel.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 18.01.2024.
//

import Foundation
import CoreLocation
import Alamofire

class WeatherViewModel {
    
    // Get Current Day Weather Data
    public func getTodayWeatherData(completion: @escaping (WeatherDataModel) -> Void) {
        WeatherManager.shared.getWeather(completion: { weatherData in
            completion(weatherData)
        })
    }
    
    
    func getWeeklyForecastData(completion: @escaping ([WeatherForecast]?, WeatherForecastDataModel?) -> Void) {
        WeatherManager.shared.getWeeklyForecast(completion: { filterData, weatherData in
            completion(filterData, weatherData)
        })
    }
    
    func getFilterWeather(data: WeatherForecastDataModel, day: String) -> [WeatherForecast] {
        lazy var weatherData: [WeatherForecast] = []

        for i in 0...(data.list?.count ?? 0) - 1 {
            if day.prefix(10) == data.list?[i].dtTxt?.prefix(10) {
                if let data = data.list?[i] {
                    weatherData.append(data)
                }
            }
        }
        return weatherData
    }
    
}
