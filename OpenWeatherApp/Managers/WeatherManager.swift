//
//  WeatherManager.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 17.01.2024.
//

import Foundation
import CoreLocation
import Alamofire
import Cache

class WeatherManager {
    
    // Variables
    static let shared = WeatherManager()
    private lazy var baseURL: String = Constants.shared.baseURL
    private lazy var apiKey: String = Constants.shared.API_KEY
    let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
        return Session(configuration: configuration)
    }()
    
    // Get Current Day Weather
    public func getWeather(completion: @escaping (WeatherDataModel) -> Void) {
        LocationManager.shared.getCurrentLocation(completion: { location in
            let contentURL: String = Constants.shared.currentWeatherURL
            let latitude: String = String(location.coordinate.latitude)
            let longitude: String = String(location.coordinate.longitude)
            
            let urlString = "\(self.baseURL)\(contentURL)lat=\(latitude)&lon=\(longitude)&appid=\(self.apiKey)"

            self.session.request(urlString).responseDecodable(of: WeatherDataModel.self) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        })
    }
    
    func getWeeklyForecast(completion: @escaping ([WeatherForecast]?, WeatherForecastDataModel) -> Void) {
        LocationManager.shared.getCurrentLocation(completion: { location in
            lazy var contentURL: String = Constants.shared.forecastWeatherURL
            let latitude: String = String(location.coordinate.latitude)
            let longitude: String = String(location.coordinate.longitude)
            
            let urlString = "\(self.baseURL)\(contentURL)lat=\(latitude)&lon=\(longitude)&appid=\(Constants.shared.API_KEY)"

            self.session.request(urlString).responseDecodable(of: WeatherForecastDataModel.self) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let value):
                    let responseValue = value
                    var firstDate: String? = nil
                    var filterData: [WeatherForecast]? = []
                    responseValue.list?.forEach({ weatherItem in
                        if firstDate == nil {
                            firstDate = weatherItem.dtTxt
                            filterData?.append(weatherItem)
                        } else if firstDate?.prefix(10) != weatherItem.dtTxt?.prefix(10) {
                            firstDate = weatherItem.dtTxt
                            filterData?.append(weatherItem)
                        }
                    })
                    completion(filterData, responseValue)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        })
    }
    
    func getWeatherTempType() -> WeatherValueTypes {
        if let storedWeatherValueType = UserDefaults.standard.value(forKey: UserDefaults.Keys.weatherValueTypes) as? String,
           let value = WeatherValueTypes(rawValue: storedWeatherValueType) {
            return value
        } else {
            return .DEFAULT
        }
    }
}
