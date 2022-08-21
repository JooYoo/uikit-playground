//
//  ArticleViewModel.swift
//  News
//
//  Created by Yu on 21.08.22.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleViewModel {
    
    let article: Article
    
    init(_ article: Article){
        self.article = article
    }
}

extension ArticleViewModel {
    
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
}
