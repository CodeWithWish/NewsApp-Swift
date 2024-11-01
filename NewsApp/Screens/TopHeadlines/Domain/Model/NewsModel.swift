//
//  NewsModel.swift
//  NewsAppPOC
//
//  Created by Vidya Mulay on 22/10/24.
//

import Foundation
import CoreData

// MARK: - News
struct News:  Codable {
    let status : String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
typealias Articles = [Article]

struct Article: Codable, Hashable {
    let source: ArticleSource?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct ArticleSource:  Codable, Hashable {
    let id, name: String?
}

// MARK: - Error Response
struct APIErrorResponse: Codable {
    let status: String?
    let code: String?
    let message: String?
}
