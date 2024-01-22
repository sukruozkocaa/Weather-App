//
//  WeatherDataModel.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 18.01.2024.
//

import Foundation

struct WeatherDataModel: Codable {
    let coord: WeatherCoord?
    let weather: [WeatherDetail]?
    let base: String?
    let main: WeatherMain?
    let visibility: Int?
    let wind: WeatherWind?
    let clouds: WeatherClouds?
    let dt: Int?
    let sys: WeatherSys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Weather Clouds
struct WeatherClouds: Codable {
    let all: Int?
}

// MARK: - Weather Coord
struct WeatherCoord: Codable {
    let lon, lat: Double?
}

// MARK: - Weather Main
struct WeatherMain: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Weather Sys
struct WeatherSys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather Detail
struct WeatherDetail: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Weather Wind
struct WeatherWind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
