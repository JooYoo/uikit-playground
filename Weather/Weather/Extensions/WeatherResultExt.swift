//
//  WeatherResultExt.swift
//  Weather
//
//  Created by Yu on 20.08.22.
//

import Foundation

extension WeatherResult {
    static var empty: WeatherResult {
      return WeatherResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}
