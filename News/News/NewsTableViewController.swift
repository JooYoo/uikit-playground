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
    var articles = [Article]()
    // Rx
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        /// set title to large
        navigationController?.navigationBar.prefersLargeTitles = true
        
       // fetch data from API
        populateNews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else{
            fatalError("cell casting error")
        }
        
        cell.titleLable.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        
        return cell
    }
    
    private func refreshTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func populateNews(){
        // build up endpoint
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(getKey())")!
        
        // fetch data from API
        Observable.just(url)
            .flatMap { url -> Observable<Data> in
                // api call
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> [Article]? in
                // decode the api data
                return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
            }.subscribe(onNext: { [weak self] articles in
                
                if let articles = articles {
                    // get data eventually
                    self?.articles = articles
                    print(self?.articles)
                    // reload table
                    self?.refreshTable()
                }
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
