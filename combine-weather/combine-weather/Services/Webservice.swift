//
//  Webservice.swift
//  combine-weather
//
//  Created by Yu on 2022/10/9.
//

import Foundation
import Combine

class Webservice {
    func fetchWeather(city: String) -> AnyPublisher<WeatherInfo, Error> {
        // get URL
        guard let url = URL(string: Constants.URLs.weather(city)) else {
            fatalError("Invalid url")
        }
        
        // fetch data
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map{ $0.main }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
