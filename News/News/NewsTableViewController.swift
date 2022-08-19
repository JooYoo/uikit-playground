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
        // fetch data from API
        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: { [weak self] articlesList in
                if let articles = articlesList?.articles {
                    // get eventual data
                    self?.articles = articles
                    print(self?.articles)
                    // reload table
                    self?.refreshTable()
                }
            }).disposed(by: bag)
    }
    
}
