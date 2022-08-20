//
//  ViewController.swift
//  Weather
//
//  Created by Yu on 19.08.22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    // Rx
    let bag = DisposeBag()
    // Outlets
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLable: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWeather()
    }
    
    func fetchWeather(){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=ulm&units=metric&appid=\(getKey())")!
        let resource = Resource<WeatherResult>(url: url)
        
        URLRequest.load(resource: resource)
            .subscribe( onNext: {  weatherResult in
                    // get weather data
                    print(weatherResult.main)
            }).disposed(by: bag)
    }

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
}

