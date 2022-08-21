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

class NewsTableViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableRef: UITableView!

    // Rx
    let bag = DisposeBag()
    private var articles = BehaviorRelay<[Article]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title to large
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // fetch articles from API
        fetchData()
        // fetched data binds to UI
        bindToTableView()
    }
    
    private func fetchData() {
        // get URL ready
        let resource = Resource<ArticlesList>(url: URL.urlForNewsAPI())
        
        // fetch data
        URLRequest.load(resource: resource)
            .subscribe( onNext: { articleList in
                if let articles = articleList?.articles{
                    self.articles.accept(articles)
                    print(self.articles)
                }
            }).disposed(by: bag)
    }
    
    private func bindToTableView(){
        // Set tableview delegate
        tableRef.rx
            .setDelegate(self)
            .disposed(by: bag)
        
        // bind articles to tableview
        articles
            .asObservable()
            .bind(to: tableRef.rx
                .items(cellIdentifier: "ArticleTableViewCell", cellType: ArticleTableViewCell.self)) { index, element, cell in
                    cell.titleLable.text = element.title
                    cell.descriptionLabel.text = element.description
                }.disposed(by: bag)
    }
}
