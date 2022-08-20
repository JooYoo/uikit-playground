//
//  URLExt.swift
//  Weather
//
//  Created by Yu on 20.08.22.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(_ city: String) -> URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(getKey())")!
    }
}

// MARK: get API_KEY
func getKey() -> String{
    // get apiKey from Bundle
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    // check if key is ok
    guard let key = apiKey, !key.isEmpty else {
        print("API key does not exist")
        return ""
    }
    
    return key
}
