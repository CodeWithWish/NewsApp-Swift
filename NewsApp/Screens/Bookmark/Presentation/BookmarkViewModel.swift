//
//  BookmarkViewModel.swift
//  NewsApp
//
//  Created by Vidya Mulay on 30/10/24.
//

import Foundation
import CoreData

struct BookmarkViewModelNavigation {
    let navigateToDetail: (_ url: URL) -> SafariView?
}

class BookmarkViewModel: ObservableObject {
    @Published var articles: Articles?
    private var navigation: BookmarkViewModelNavigation
    private var newsRepo: NewsListRepositoryProtocol
    
    init(navigation: BookmarkViewModelNavigation, newsRepo: NewsListRepositoryProtocol) {
        self.navigation = navigation
        self.newsRepo = newsRepo
    }
    
    func fetchFromCoreData()  {
        articles = newsRepo.fetchSavedArticles()
    }
    
    func navigateToWebView(url: URL) -> SafariView? {
        return navigation.navigateToDetail(url)
    }
}
