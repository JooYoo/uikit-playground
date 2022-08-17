//
//  NewsTableViewController.swift
//  News
//
//  Created by Yu on 17.08.22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        /// set title to large
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // get API_KEY
        let key = getKey()
        print(key)
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
