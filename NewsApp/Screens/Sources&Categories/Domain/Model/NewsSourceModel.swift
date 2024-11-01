//
//  NewsSourceModel.swift
//  NewsAppPOC
//
//  Created by Vidya Mulay on 22/10/24.
//

import Foundation

// MARK: - NewsSource
struct NewsSource: Codable {
    let status: String?
    let sources: [Source]?
}

typealias Sources = [Source]

// MARK: - Source
struct Source: Codable, Hashable {
    let id, name, description: String?
    let url: String?
    let category, language, country: String?
}
