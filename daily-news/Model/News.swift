//
//  Search.swift
//  daily-news
//
//  Created by gumball on 2/24/22.
//

import Foundation

struct Author: Decodable {
    let name: String
}

struct New: Decodable {
    let title: String
    let image: String
    let publishedAt: String
    let content: String
    let source: Author
}

struct News: Decodable {
    let totalArticles: Int
    var articles: [New]
}
