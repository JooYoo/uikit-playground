//
//  ViewController.swift
//  combine-weather
//
//  Created by Yu on 2022/10/9.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var temperature: UILabel!
    
    // get dependency of Webservice
    private var webservice = Webservice()
    // Combine: an AnyCancellable instance automatically calls cancel() when deinitialized
    private var cancelable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPublisher()
    }
    
    private func setupPublisher(){
        // set default state
        temperature.text = "🍃"
        // publisher
        let publisher = NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: cityTextField)
        // subscription
        cancelable = publisher
            .compactMap{
                ($0.object as! UITextField).text?
                    .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .flatMap{ city in
                return self.webservice.fetchWeather(city: city)
                    .catch{ _ in Just(WeatherInfo.placeholder)}
                    .map{ data in
                        if let temp = data.temp {
                            return "\(temp) ℃"
                        } else {
                            return "🍃"
                        }
                    }
            }
            .assign(to: \.text, on: self.temperature)
    }
}
