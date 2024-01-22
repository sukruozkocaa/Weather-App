//
//  WeatherForecastDataModel.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 19.01.2024.
//

import Foundation

// MARK: - WeatherForecastDataModel
struct WeatherForecastDataModel: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [WeatherForecast]?
    let city: WeatherForecastCity?
}

// MARK: - WeatherForecastCity
struct WeatherForecastCity: Codable {
    let id: Int?
    let name: String?
    let coord: WeatherCoord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - WeatherForecast
struct WeatherForecast: Codable {
    let dt: Int?
    let main: WeatherMainClass?
    let weather: [WeatherForecastStatus]?
    let clouds: WeatherClouds?
    let wind: WeatherForecastWind?
    let visibility: Int?
    let pop: Double?
    let rain: WeatherRain?
    let sys: WeatherForecastSys?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass
struct WeatherMainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct WeatherRain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct WeatherForecastSys: Codable {
    let pod: String?
}

// MARK: - Weather
struct WeatherForecastStatus: Codable {
    let id: Int?
    let main: String?
    let description, icon: String?
}

// MARK: - Wind
struct WeatherForecastWind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
