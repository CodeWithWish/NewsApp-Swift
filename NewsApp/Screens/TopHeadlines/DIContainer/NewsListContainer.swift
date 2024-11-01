//
//  NewsListContainer.swift
//  NewsApp
//
//  Created by Vidya Mulay on 26/10/24.
//

import Foundation
import Swinject

class NewsListContainer {
    let defaultContainer = Container()

    func registerDependencies() {
        defaultContainer.register(NewsListViewModel.self) { (resolver,  navigations: NewsListViewModelNavigation, newsRepo: NewsListRepositoryProtocol) in
            return NewsListViewModel(navigation: navigations, newsRepo: newsRepo)
        }
        defaultContainer.register(NewsListView.self) { (resolver, navigations: NewsListViewModelNavigation, newsRepo: NewsListRepositoryProtocol) in
            return NewsListView(viewModel: resolver.resolve(NewsListViewModel.self, arguments: navigations, newsRepo)!)
        }
        defaultContainer.register(NewsListRepositoryProtocol.self) { _ in
            return NewsListRepository()
        }
        defaultContainer.register(SafariView.self) { (resolver, url: URL) in
            return SafariView(url: url)
        }
    }
}
