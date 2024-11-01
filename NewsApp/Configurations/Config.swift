//
//  Config.swift
//  NewsAppPOC
//
//  Created by Vidya Mulay on 22/10/24.
//

import Foundation
import Alamofire

protocol ConfigurationProtocol {
    var locale: String { get }
    var region: String { get }
    var baseURL: String { get }
    var absoluteURL: String { get }
    var parameters: [String: String]? { get }
    var headers: HTTPHeaders { get }
}

extension ConfigurationProtocol {
    var locale: String {
        return "en"
    }
    
    var region: String {
        return "us"
    }
}

public enum Configuration: ConfigurationProtocol {
    case topHeadlines
    case allNews
    case getSources
    
    // A date and optional time for the oldest article. This should be in ISO 8601 format
    case sortByDate(_ from: String, _ to: String)
    
    // News sources or blogs you want headlines from.
    case sortBySource(_ source: String)
    
    case sortByCategory(_ category: String)
    
    // The order to sort the articles in
    case sortBy(_ sorting: String)
    
    // Keywords or phrases to search for in the article title and body.
    case sortByQuery(_ q: String)
    
    // Domains to restrict the search to.
    case sortByDomain(_ domain: String)
        
    var apiKey: String {
        return "4fa0c71731814d3db39f853d33c3775c"
    }
    
    var baseURL: String {
        return "https://newsapi.org/v2"
    }
    
    var absoluteURL: String {
        switch self {
        case .topHeadlines, .sortByCategory, .sortBySource :
            return baseURL + "/top-headlines"
            
        case .allNews, .sortByDate, .sortByQuery, .sortBy, .sortByDomain :
            return baseURL + "/everything"
        
        case .getSources :
            return baseURL + "/sources"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .topHeadlines:
            return ["country": region]
            
        case .allNews:
            return [:]
            
        case .getSources:
            return ["language": locale, "country": region]
            
        case .sortByDate(let from,let to):
            return ["from": from, "to": to]
            
        case .sortBySource(let source):
            return ["sources": source]
            
        case .sortByCategory(let category):
            return ["category": category]
            
        case .sortBy(let sorting):
            return ["sortBy": sorting]
            
        case .sortByQuery(let q):
            return ["q": q]
            
        case .sortByDomain(let domain):
            return ["domains": domain]
        }
    }
    
    var headers: HTTPHeaders {
        return [
            "X-Api-Key": apiKey,
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
}
    
/* List of possible News APIs
 //https://newsapi.org/v2/everything?q=apple&from=2024-10-21&to=2024-10-21&sortBy=popularity&apiKey=680b4afcc1e14cce88126825b7664ba7
 //https://newsapi.org/v2/everything?q=tesla&from=2024-09-22&sortBy=publishedAt&apiKey=680b4afcc1e14cce88126825b7664ba7
 //https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=680b4afcc1e14cce88126825b7664ba7
 //https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=680b4afcc1e14cce88126825b7664ba7
 //https://newsapi.org/v2/everything?domains=wsj.com&apiKey=680b4afcc1e14cce88126825b7664ba7
 */

