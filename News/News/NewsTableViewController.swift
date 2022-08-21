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
    private var articleListVM: ArticleListViewModel!
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
        return articleListVM == nil ? 0 : articleListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else{
            fatalError("cell casting error")
        }
        
        let articleVM = articleListVM.articleAt(indexPath.row)
        
        articleVM.title
            .asDriver(onErrorJustReturn: "🍃")
            .drive(cell.titleLable.rx.text)
            .disposed(by: bag)
        
        articleVM.description
            .asDriver(onErrorJustReturn: "🍃")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: bag)
        
        return cell
    }
    
    private func refreshTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func populateNews(){
        let resource = Resource<ArticlesList>(url: URL.urlForNewsAPI())
        
        // fetch data from API
        URLRequest.load(resource: resource)
            .subscribe(onNext: { articlesList in
                let articles = articlesList?.articles
                self.articleListVM = ArticleListViewModel(articles!)
                // refresh Table
                self.refreshTable()
            }).disposed(by: bag)
    }
}
