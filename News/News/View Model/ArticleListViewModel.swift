//
//  ArticleListViewModel.swift
//  News
//
//  Created by Yu on 21.08.22.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    let articlesVM: [ArticleViewModel]
    
    init(_ articles: [Article]){
        articlesVM = articles.compactMap(ArticleViewModel.init)
    }
    
    func articleAt(_ index: Int) -> ArticleViewModel {
        return articlesVM[index]
    }
}
