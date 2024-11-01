//
//  NewsListViewModelTest.swift
//  NewsAppTests
//
//  Created by Vidya Mulay on 31/10/24.
//

import XCTest
@testable import NewsApp

final class NewsListViewModelTests: XCTestCase {
    private var viewModel: NewsListViewModel!
    private var mockNavigation: NavigationMock!
    private var mockRepository: NewsListRepositoryMock!
    private var navigation: NewsListViewModelNavigation!

    override func setUp() {
        super.setUp()
        mockNavigation = NavigationMock()
        mockRepository = NewsListRepositoryMock()
        navigation = NewsListViewModelNavigation(navigateToDetail: mockNavigation.navigateToSafari)
        viewModel = NewsListViewModel(navigation: navigation, newsRepo: mockRepository)
    }

    override func tearDown() {
        super.tearDown()
        mockNavigation = nil
        mockRepository = nil
        navigation = nil
        viewModel = nil
    }
    
    func testExecuteFetchTopHeadlineSuccess() async {
        // Given
        mockRepository.mockNews = NewsMock().mockNews
        let expectation = self.expectation(description: "Successful fetch of top headlines")
        
        // When
        await viewModel.executeFetchTopHeadline()
        
        // Then
        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.errorMessage, "")
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testExecuteFetchTopHeadlineError() async {
        // Given
        mockRepository.mockError = NSError(domain: "unitTest", code: 401)
        let expectation = self.expectation(description: "Failure fetch of top headlines")
        
        // When
        await viewModel.executeFetchTopHeadline()
        
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

class NavigationMock {
    var safariCalled = false
    func navigateToSafari(url: URL) -> SafariView? {
        safariCalled = true
        return nil
    }
}
