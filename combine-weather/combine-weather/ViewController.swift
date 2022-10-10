//
//  ViewController.swift
//  combine-weather
//
//  Created by Yu on 2022/10/9.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = Webservice().fetchWeather(city: "test")
        print(test)
    }
}

