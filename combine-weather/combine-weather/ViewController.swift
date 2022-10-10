//
//  ViewController.swift
//  combine-weather
//
//  Created by Yu on 2022/10/9.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var temperature: UILabel!
    
    // get dependency of Webservice
    private var webservice = Webservice()
    // Combine: an AnyCancellable instance automatically calls cancel() when deinitialized
    private var cancelable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelable = webservice
            .fetchWeather(city: "Ulm")
            .catch{_ in Just(WeatherInfo.placeholder)}
            .map{ data in
                if let temp = data.temp {
                    return "\(temp) ℃"
                } else {
                    return "🐞"
                }
            }
            .assign(to: \.text, on: self.temperature)
    }
}

