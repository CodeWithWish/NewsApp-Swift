//
//  NewsFromSourceViewModelTest.swift
//  NewsAppTests
//
//  Created by Vidya Mulay on 01/11/24.
//

import XCTest
@testable import NewsApp

final class NewsFromSourceViewModelTest: XCTestCase {
    private var viewModel: NewsFromSourceViewModel!
    private var mockNavigation: NavigationMock!
    private var mockRepository: NewsListRepositoryMock!
    private var navigation: NewsFromSourceViewModelNavigation!
    private var mockSource: Source!

    override func setUp() {
        super.setUp()
        mockNavigation = NavigationMock()
        mockRepository = NewsListRepositoryMock()
        navigation = NewsFromSourceViewModelNavigation(navigateToDetail: mockNavigation.navigateToSafari)
        mockSource = NewsMock().mockSources.sources?[0]
        viewModel = NewsFromSourceViewModel(source: mockSource, navigation: navigation, newsRepo: mockRepository)
    }

    override func tearDown() {
        super.tearDown()
        mockNavigation = nil
        mockRepository = nil
        navigation = nil
        viewModel = nil
        mockSource = nil
    }
    
    func testExecuteFetchArticlesSuccess() async {
        // Given
        mockRepository.mockNews = NewsMock().mockNews
        let expectation = self.expectation(description: "Successful fetch of top headlines")
        
        // When
        await viewModel.executeNews(for: "WPVI-TV")
        
        // Then
        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.errorMessage, "")
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func estExecuteFetchArticlesError() async {
        // Given
        mockRepository.mockError = NSError(domain: "unitTest", code: 401)
        let expectation = self.expectation(description: "Failure fetch of top headlines")
        
        // When
        await viewModel.executeNews(for: "test")
        
        // Then
        XCTAssertEqual(viewModel.articles.count, 0)
        XCTAssertNotEqual(viewModel.errorMessage, "")
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testNavigationToSafari() {
        // Given
        let mockUrl = URL(string: "www.google.com")!
        // When
        let _ = viewModel.navigateToWebView(url: mockUrl)
        // Then
        XCTAssertTrue(mockNavigation.safariCalled)
    }
}
