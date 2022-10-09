//
//  Weather.swift
//  combine-weather
//
//  Created by Yu on 2022/10/9.
//

import Foundation

struct WeatherResponse: Codable {
    let main: WeatherInfo
}

struct WeatherInfo: Codable {
    let temp: Double?
    let humidity: Double?
    
    static var placeholder: WeatherInfo {
        return WeatherInfo(temp: nil, humidity: nil)
    }
}
