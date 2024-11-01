//
//  Sources&CategoriesCoordinator.swift
//  NewsApp
//
//  Created by Vidya Mulay on 30/10/24.
//

import Foundation
import SwiftUI

final class SourcesAndCategoriesCoordinator {
    // MARK: - Private  Variables
    private var dependencyContainer: SourcesAndCategoriesContainer
    
    init(container: SourcesAndCategoriesContainer) {
        dependencyContainer = container
    }
    
    func getView() -> SourceAndCategoriesView? {
        let navigation = SourcesAndCategoriesViewModelNavigation(navigateToSourceArticles: navigateToSourceArticles(_:), navigateToCategoryArticles: navigateToCategoryArticles(_:))
        
        guard let newsRepo = dependencyContainer.defaultContainer.resolve(NewsListRepositoryProtocol.self), let view = dependencyContainer.defaultContainer.resolve(SourceAndCategoriesView.self, arguments: navigation, newsRepo) else { return nil }
        return view
    }
    
    func navigateToWebView(_ url: URL) -> SafariView? {
        guard let safariView = dependencyContainer.defaultContainer.resolve(SafariView.self, argument: url) else {
            return nil
        }
        return safariView
    }
    
    func navigateToSourceArticles(_ source: Source) -> NewsFromSourceView? {
        let navigation = NewsFromSourceViewModelNavigation(navigateToDetail: navigateToWebView(_:))
        
        guard let newsRepo = dependencyContainer.defaultContainer.resolve(NewsListRepositoryProtocol.self), let view = dependencyContainer.defaultContainer.resolve(NewsFromSourceView.self, arguments: source, navigation, newsRepo) else { return nil }
        return view
    }
    
    func navigateToCategoryArticles(_ category: String) -> NewsFromCategoryView? {
        let navigation = NewsFromCategoryViewModelNavigation(navigateToDetail: navigateToWebView(_:))
        
        guard let newsRepo = dependencyContainer.defaultContainer.resolve(NewsListRepositoryProtocol.self), let view = dependencyContainer.defaultContainer.resolve(NewsFromCategoryView.self, arguments: category, navigation, newsRepo) else { return nil }
        return view
    }
}
