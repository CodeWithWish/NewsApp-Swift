//
//  BookmarkContainer.swift
//  NewsApp
//
//  Created by Vidya Mulay on 01/11/24.
//


import Foundation
import Swinject

class BookmarkContainer {
    let defaultContainer = Container()

    func registerDependencies() {
        defaultContainer.register(BookmarkViewModel.self) { (resolver,  navigations: BookmarkViewModelNavigation, newsRepo: NewsListRepositoryProtocol) in
            return BookmarkViewModel(navigation: navigations, newsRepo: newsRepo)
        }
        defaultContainer.register(BookmarkView.self) { (resolver, navigations: BookmarkViewModelNavigation, newsRepo: NewsListRepositoryProtocol) in
            return BookmarkView(viewModel: resolver.resolve(BookmarkViewModel.self, arguments: navigations, newsRepo)!)
        }
        defaultContainer.register(NewsListRepositoryProtocol.self) { _ in
            return NewsListRepository()
        }
        defaultContainer.register(SafariView.self) { (resolver, url: URL) in
            return SafariView(url: url)
        }
    }
}
