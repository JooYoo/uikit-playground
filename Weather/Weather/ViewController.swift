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
        
        // Rx: subscribe to cityNameTextField
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .map{self.cityNameTextField.text}
            .subscribe(onNext:{ cityName in
                if let cityName = cityName {
                    if cityName.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(cityName)
                    }
                }
            }).disposed(by: bag)
    }
    
    // MARK: display data on UI
    func displayWeather(_ weather: Weather?){
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) ℉"
            self.humidityLable.text = "\(weather.humidity) 💧"
        } else {
            self.temperatureLabel.text = "🍃"
            self.humidityLable.text = "🍃"
        }
    }
    
    func fetchWeather(_ cityName: String){
        let resource = Resource<WeatherResult>(url: URL.urlForWeatherAPI(cityName))
        
        URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(WeatherResult.empty)
            .subscribe( onNext: {  weatherResult in
                // get weather data
                self.displayWeather(weatherResult.main)
            }).disposed(by: bag)
    }
}

