//
//  File.swift
//  NewsApp
//
//  Created by Vidya Mulay on 27/10/24.
//

import Foundation
import CoreData

// A repository layer to get the desired data from Network manager and give the data to the viewModel

protocol NewsListRepositoryProtocol {
    func getNews<T: Codable>(config: Configuration) async -> (T?, Error?)
    func fetchSavedArticles() -> Articles? 
}

class NewsListRepository: NewsListRepositoryProtocol {
    func getNews<T: Codable>(config: Configuration) async -> (T?, Error?) {
        do {
            guard let data = try await NetworkManager.shared.get(request: config) else { return (nil, nil) }
            let result: T = try self.parseData(data: data)
            return (result, nil)
        } catch let error {
            print(error.localizedDescription)
            return (nil, error)
        }
    }
    
    func fetchSavedArticles() -> Articles? {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        
        do {
            let articleEntities = try context.fetch(fetchRequest)
            var articles: Articles
            articles = articleEntities.compactMap { entity in
                
                return Article(
                    source: ArticleSource(id: entity.sourceId, name: entity.sourceName),
                    author: entity.author,
                    title: entity.title,
                    description: entity.desc,
                    url: entity.url,
                    urlToImage: entity.urlToImage,
                    publishedAt: entity.publishedAt,
                    content: entity.content
                )
            }
            return articles
        } catch {
            print("Failed to fetch articles: \(error)")
        }
        return nil
    }
    
    private func parseData<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let decodedData = try? decoder.decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
    }
}

