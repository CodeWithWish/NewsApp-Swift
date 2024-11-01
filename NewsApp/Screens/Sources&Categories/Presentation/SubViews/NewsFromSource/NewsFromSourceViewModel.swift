//
//  NewsFromSourceViewModel.swift
//  NewsApp
//
//  Created by Vidya Mulay on 28/10/24.
//

import Foundation

struct NewsFromSourceViewModelNavigation {
    let navigateToDetail: (_ url: URL) -> SafariView?
}

class NewsFromSourceViewModel: ObservableObject {
    @Published var articles: Articles = []
    @Published var errorMessage = ""

    var source: Source
    private var navigation: NewsFromSourceViewModelNavigation
    private var newsRepo: NewsListRepositoryProtocol
    
    init(source: Source, navigation: NewsFromSourceViewModelNavigation, newsRepo: NewsListRepositoryProtocol) {
        self.navigation = navigation
        self.source = source
        self.newsRepo = newsRepo
    }
    
    func executeNews(for source: String) async {
        await MainActor.run {
            self.errorMessage = ""
        }
        let (response, error): (News?, Error?)  = await newsRepo.getNews(config: .sortBySource(source))
        if let news = response  {
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
