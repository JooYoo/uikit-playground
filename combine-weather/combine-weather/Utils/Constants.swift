//
//  Constants.swift
//  combine-weather
//
//  Created by Yu on 2022/10/9.
//

import Foundation

struct Constants {
    struct URLs {
        static func weather(_ city: String) -> String {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(getKey())"
        }
        
        static func getKey() -> String{
             // get apiKey from Bundle
             let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
             
             // check if key is ok
             guard let key = apiKey, !key.isEmpty else {
                 print("API key does not exist")
                 return ""
             }
             return key
         }
    }
}
