//
//  Article.swift
//  NEWS
//
//  Created by Shreeya Maskey on 9/16/21.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

extension ArticlesList {
    static var all: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=c1cec0643f4d45d08fee049527f860b4")!
        return Resource(url: url)
    }()
    
}

struct Article: Decodable {
    let title: String?
    let description: String?
}
