//
//  NewsFromCategoryViewModel.swift
//  NewsApp
//
//  Created by Vidya Mulay on 29/10/24.
//

import Foundation

struct NewsFromCategoryViewModelNavigation {
    let navigateToDetail: (_ url: URL) -> SafariView?
}

class NewsFromCategoryViewModel: ObservableObject {
    @Published var articles: Articles = []
    @Published var errorMessage = ""
    @Published var category: String
    
    private var navigation: NewsFromCategoryViewModelNavigation
    private var newsRepo: NewsListRepositoryProtocol
    
    init(category: String, navigation: NewsFromCategoryViewModelNavigation, newsRepo: NewsListRepositoryProtocol) {
        self.navigation = navigation
        self.category = category
        self.newsRepo = newsRepo
    }
    
    func executeNews() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        let (response, error): (News?, Error?)  = await newsRepo.getNews(config: .sortByCategory(category))
        if let news = response {
            await MainActor.run {
                print("Fetched articles count: \(news.articles?.count ?? 0)")
                self.articles = news.articles ?? []
            }
        } else {
            await MainActor.run {
                self.errorMessage = error?.localizedDescription ?? "Fetch data failed"
            }
        }
    }
    
    func navigateToWebView(url: URL) -> SafariView? {
        return navigation.navigateToDetail(url)
    }
}
