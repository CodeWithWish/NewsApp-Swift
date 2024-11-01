//
//  SourcesAndCategoriesViewModel.swift
//  NewsApp
//
//  Created by Vidya Mulay on 28/10/24.
//

import Foundation
import SwiftUI

struct SourcesAndCategoriesViewModelNavigation {
    var navigateToSourceArticles : (_ source: Source) -> NewsFromSourceView?
    var navigateToCategoryArticles : (_ category: String) -> NewsFromCategoryView?
}

class SourcesAndCategoriesViewModel: ObservableObject {
    @Published var sources: Sources = []
    @Published var errorMessage = ""
    
    private var navigation: SourcesAndCategoriesViewModelNavigation
    private var newsRepo: NewsListRepositoryProtocol
    
    init(navigation: SourcesAndCategoriesViewModelNavigation, newsRepo: NewsListRepositoryProtocol) {
        self.navigation = navigation
        self.newsRepo = newsRepo
    }
    
    func getIcon(for category: NewsCategory?) -> String {
        switch category {
        case .business:
            return "business_icon"
        case .entertainment:
            return "entertaintment_icon"
        case .general:
            return "general_icon"
        case .health:
            return "health_icon"
        case .science:
            return "science_icon"
        case .sports:
            return "sports_icon"
        case .technology:
            return "technology_icon"
        case .none:
            return "business_icon"
        }
    }
    
    func executeGetSources() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        let (response, error): (NewsSource?, Error?)  = await newsRepo.getNews(config: .getSources)
        if let news = response {
            await MainActor.run {
                self.sources = news.sources ?? []
            }
        } else {
            await MainActor.run {
                self.errorMessage = error?.localizedDescription ?? "Fetch data failed"
            }
        }
    }
    
    func getCategoryNews(category: String) -> NewsFromCategoryView? {
        return navigation.navigateToCategoryArticles(category)
    }
    
    func getSourceNews(source: Source) -> NewsFromSourceView? {
        return navigation.navigateToSourceArticles(source)
    }
}
