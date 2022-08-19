//
//  ArticlesListExt.swift
//  News
//
//  Created by Yu on 19.08.22.
//

import Foundation

extension ArticlesList {
    static let all: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(getKey())")!
        return Resource(url: url)
    }()
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
