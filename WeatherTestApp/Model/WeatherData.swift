//
//  WeatherData.swift
//  WeatherTestApp
//
//  Created by Roman Korobskoy on 30.12.2021.
//

import Foundation

struct WeatherData: Codable {
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
}

struct Info: Codable {
    let url: String
}

struct Fact: Codable {
    let temp: Int
    let icon: String
    let condition: String
    let windSpeed: Int
    let pressureMm: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, icon, condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
    }
}

struct Forecast: Codable {
    let parts: Parts
}

struct Parts: Codable {
    let day: Day
}

struct Day: Codable {
    let tempMin: Int = 0
    let tempMax: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
