//
//  Weather.swift
//  Weather-Task
//
//  Created by Himansu Sekhar Panigrahi on 07/01/25.
//

import Foundation

struct WeatherResponse: Codable {
    let list: [Forecast]?
}

struct Forecast: Codable {
    let date: Date?
    let main: Main?
    let weather: [Weather]?
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
    }
    
    func getDate() -> String{
        guard let date = date else {
            return Const.notAvailable
        }
        return DateFormatter.shortTime.string(from: date)
    }
}

struct Main: Codable {
    let temp: Double?
    
    func getTemp() -> String{
        guard let temp = temp else {
            return Const.notAvailable
        }
        return String(format: "%.1f", temp) + "°C"
    }
}

struct Weather: Codable {
    let description: String?
    let icon: String?
    let main: String?
}

