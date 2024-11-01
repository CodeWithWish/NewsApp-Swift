//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Vidya Mulay on 27/10/24.
//

import Foundation
import SwiftUI

struct NewsListViewModelNavigation {
    let navigateToDetail: (_ url: URL) -> SafariView?
}

class NewsListViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var articles: Articles = []
    
    private var navigation: NewsListViewModelNavigation
    private var newsRepo: NewsListRepositoryProtocol
    
    init(navigation: NewsListViewModelNavigation, newsRepo: NewsListRepositoryProtocol) {
        self.navigation = navigation
        self.newsRepo = newsRepo
    }
    
    func executeFetchTopHeadline() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        let (response, error): (News?, Error?)  = await newsRepo.getNews(config: .topHeadlines)
        if let news = response {
            await MainActor.run {
                self.articles = news.articles ?? []
            }
        } else {
            await MainActor.run {
                self.errorMessage = error?.localizedDescription ?? "Unable to fetch the data"
            }
        }
    }
    
    func editFavorite(for article: Article) {
        if article.isArticleSaved() {
            article.deleteArticle()
        } else {
            article.saveToCoreData()
        }
    }
    
    func navigateToWebView(url: URL) -> SafariView? {
        return navigation.navigateToDetail(url)
    }
}

