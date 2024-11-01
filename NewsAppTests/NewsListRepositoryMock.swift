//
//  NewsRepositoryMock.swift
//  NewsAppTests
//
//  Created by Vidya Mulay on 31/10/24.
//

import XCTest
@testable import NewsApp

class NewsListRepositoryMock: NewsListRepositoryProtocol {
    var mockNews: News?
    var mockSources: NewsSource?
    var mockError: Error?
    var savedArticles: Articles?
    
    func getNews<T: Codable>(config: Configuration) async -> (T?, Error?) {
        if T.self == News.self {
            return (mockNews as? T, mockError)
        } else if T.self == NewsSource.self {
            return (mockSources as? T, mockError)
        }
        return (nil, mockError)
    }
    
    func fetchSavedArticles() -> Articles? {
        return savedArticles
    }
}

class NewsMock {
    var mockNews: News
    var mockSources: NewsSource
    
    init() {
        mockNews = News(
            status: "ok",
            totalResults: 1,
            articles: [
                Article(
                    source: ArticleSource(id: nil, name: "WPVI-TV"),
                    author: "6abc philadelphia",
                    title: "Elon no-show at $1M voter giveaway hearing...",
                    description: "Elon Musk was a no-show in a Philadelphia courtroom for a hearing over the legality of his $1 million a day giveaway.",
                    url: "https://6abc.com/post/elon-musk-tries-move-case-1m-voter-sweepstakes-federal-court-averting-required-philadelphia-appearance/15492202/",
                    urlToImage: "https://cdn.abcotvs.com/dip/images/15492795_103124-wpvi-musk-court-hearing-12pm-video-vid.jpg?w=1600",
                    publishedAt: "2024-10-31T16:00:03Z",
                    content: "PHILADELPHIA -- A judge in Philadelphia held a brief hearing Thursday in the city prosecutor's bid to shut down Elon Musk's $1 million-a-day sweepstakes in battleground states. The giveaways come fro… [+2947 chars]"
                )
            ]
        )
        
        mockSources = NewsSource(status: "ok", sources: [Source(
            id: "abc-news",
            name: "ABC News",
            description: "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
            url: "https://abcnews.go.com",
            category: "general",
            language: "en",
            country: "us"
        )])
    }
}
