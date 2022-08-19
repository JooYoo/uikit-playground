//
//  Article.swift
//  News
//
//  Created by Yu on 17.08.22.
//

import Foundation

struct ArticlesList: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
}
