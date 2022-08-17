//
//  ViewController.swift
//  News
//
//  Created by Yu on 17.08.22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let apiKey = getKey()
        print(apiKey)
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

