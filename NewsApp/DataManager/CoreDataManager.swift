//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Vidya Mulay on 30/10/24.
//

import Foundation
import CoreData

// A manager class to handle the core data management
class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

extension Article {
    func saveToCoreData() {
        let context = CoreDataManager.shared.context
        let articleEntity = ArticleEntity(context: context)
        
        articleEntity.sourceName = self.source?.name
        articleEntity.sourceId = self.source?.id
        articleEntity.author = self.author
        articleEntity.title = self.title
        articleEntity.desc = self.description
        articleEntity.url = self.url
        articleEntity.urlToImage = self.urlToImage
        articleEntity.publishedAt = self.publishedAt
        articleEntity.content = self.content
        
        do {
            try context.save()
            print("Article saved sucessfully")
        } catch {
            print("Failed to save article: \(error)")
        }
    }
    
    func isArticleSaved() -> Bool {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        
        // Set up the predicate to check for the specific URL
        let titlePredicate = NSPredicate(format: "title == %@", self.title ?? "")
        let namePredicate = NSPredicate(format: "sourceName == %@", self.source?.name ?? "")
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [titlePredicate, namePredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty // Return true if there are results, false otherwise
        } catch {
            print("Failed to fetch article: \(error)")
            return false
        }
    }
    
    func deleteArticle() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        
        // Set up the predicate to check for the specific URL
        let titlePredicate = NSPredicate(format: "title == %@", self.title ?? "")
        let namePredicate = NSPredicate(format: "sourceName == %@", self.source?.name ?? "")
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [titlePredicate, namePredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let results = try context.fetch(fetchRequest)
            for article in results {
                context.delete(article)
            }
            try context.save()
            print("Article deleted successfully.")
        } catch {
            print("Failed to delete article: \(error)")
        }
    }
}
