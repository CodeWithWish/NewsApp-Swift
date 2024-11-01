//
//  Sources&CategoriesContainer.swift
//  NewsApp
//
//  Created by Vidya Mulay on 30/10/24.
//

import Foundation
import Swinject

class SourcesAndCategoriesContainer {
    let defaultContainer = Container()
    
    func registerDependencies() {
        defaultContainer.register(SourcesAndCategoriesViewModel.self) { (resolver,  navigations: SourcesAndCategoriesViewModelNavigation, newsRepo: NewsListRepositoryProtocol) in
            return SourcesAndCategoriesViewModel(navigation: navigations, newsRepo: newsRepo)
        }
        
        defaultContainer.register(SourceAndCategoriesView.self) { (resolver, navigations: SourcesAndCategoriesViewModelNavigation, newsRepo: NewsListRepositoryProtocol) in
            return SourceAndCategoriesView(viewModel: resolver.resolve(SourcesAndCategoriesViewModel.self, arguments: navigations, newsRepo)!)
        }
        
        defaultContainer.register(NewsFromSourceViewModel.self) { (resolver, source: Source,  navigations: NewsFromSourceViewModelNavigation, newsRepo: NewsListRepositoryProtocol) in
            return NewsFromSourceViewModel(source: source, navigation: navigations, newsRepo: newsRepo)
        }
        
        defaultContainer.register(NewsFromSourceView.self) { (resolver, source: Source, navigations: NewsFromSourceViewModelNavigation , newsRepo: NewsListRepositoryProtocol) in
            return NewsFromSourceView(viewModel: resolver.resolve(NewsFromSourceViewModel.self, arguments: source, navigations, newsRepo)!)
        }
        
        defaultContainer.register(NewsFromCategoryViewModel.self) { (resolver, category: String, navigations: NewsFromCategoryViewModelNavigation, newsRepo: NewsListRepositoryProtocol) in
            return NewsFromCategoryViewModel(category: category, navigation: navigations, newsRepo: newsRepo)
        }
        
        defaultContainer.register(NewsFromCategoryView.self) { (resolver, category: String, navigations: NewsFromCategoryViewModelNavigation, newsRepo: NewsListRepositoryProtocol) in
            return NewsFromCategoryView(viewModel: resolver.resolve(NewsFromCategoryViewModel.self, arguments: category, navigations, newsRepo)!)
        }
        
        defaultContainer.register(NewsListRepositoryProtocol.self) { _ in
            return NewsListRepository()
        }
        
        defaultContainer.register(SafariView.self) { (resolver, url: URL) in
            return SafariView(url: url)
        }
    }
}

