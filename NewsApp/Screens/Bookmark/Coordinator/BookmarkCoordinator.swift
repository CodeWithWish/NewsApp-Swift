//
//  BookmarkCoordinator.swift
//  NewsApp
//
//  Created by Vidya Mulay on 01/11/24.
//

import Foundation

final class BookmarkCoordinator {
    // MARK: - Private  Variables
    private var dependencyContainer: BookmarkContainer
    
    init(container: BookmarkContainer) {
        dependencyContainer = container
    }
    
    func getView() -> BookmarkView? {
        let navigation = BookmarkViewModelNavigation(navigateToDetail: navigateToWebView(_:))
        guard let newsRepo = dependencyContainer.defaultContainer.resolve(NewsListRepositoryProtocol.self), let view = dependencyContainer.defaultContainer.resolve(BookmarkView.self, arguments: navigation, newsRepo) else { return nil }
        return view
    }
    
    func navigateToWebView(_ url: URL) -> SafariView? {
        guard let safariView = dependencyContainer.defaultContainer.resolve(SafariView.self, argument: url) else {
            return SafariView(url: url)
        }
        return safariView
    }
}
