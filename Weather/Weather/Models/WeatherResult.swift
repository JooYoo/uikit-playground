//
//  WeatherResult.swift
//  Weather
//
//  Created by Yu on 20.08.22.
//

import Foundation

struct WeatherResult: Codable {
    let main: Weather
}

struct Weather: Codable {
    let temp: Double
    let humidity: Double
}
