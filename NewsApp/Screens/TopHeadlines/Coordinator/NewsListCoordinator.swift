//
//  NewsListCoordinator.swift
//  NewsApp
//
//  Created by Vidya Mulay on 26/10/24.
//

import Foundation
import SwiftUI

final class NewsListCoordinator {
    // MARK: - Private  Variables
    private var dependencyContainer: NewsListContainer
    
    init(container: NewsListContainer) {
        dependencyContainer = container
    }
    
    func getView() -> NewsListView? {
        let navigation = NewsListViewModelNavigation(navigateToDetail: navigateToWebView(_:))
        guard let newsRepo = dependencyContainer.defaultContainer.resolve(NewsListRepositoryProtocol.self),  let view = dependencyContainer.defaultContainer.resolve(NewsListView.self, arguments: navigation, newsRepo) else { return nil }
        return view
    }
    
    func navigateToWebView(_ url: URL) -> SafariView? {
        guard let safariView = dependencyContainer.defaultContainer.resolve(SafariView.self, argument: url) else {
            return SafariView(url: url)
        }
        return safariView
    }
}
