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
                    self.fetchWeather(cityName)
                }
            }).disposed(by: bag)
    }
    
    // MARK: display data on UI    
    func fetchWeather(_ cityName: String){
        let resource = Resource<WeatherResult>(url: URL.urlForWeatherAPI(cityName))
        
        let searchObservable = URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(WeatherResult.empty)
        
        // bind to temperatureLable
        searchObservable.map{ "\($0.main.temp) ℉"}
            .bind(to: self.temperatureLabel.rx.text)
            .disposed(by: bag)
        
        // bind to humidityLable
        searchObservable.map{ "\($0.main.humidity) 💧" }
            .bind(to: self.humidityLable.rx.text)
            .disposed(by: bag)
    }
}

