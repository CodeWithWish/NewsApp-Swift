//
//  BookmarkViewModelTests.swift
//  NewsAppTests
//
//  Created by Vidya Mulay on 01/11/24.
//

import XCTest
@testable import NewsApp

final class BookmarkViewModelTests: XCTestCase {
    private var viewModel: BookmarkViewModel!
    private var mockNavigation: NavigationMock!
    private var mockRepository: NewsListRepositoryMock!
    private var navigation: BookmarkViewModelNavigation!
    
    override func setUp() {
        super.setUp()
        mockNavigation = NavigationMock()
        mockRepository = NewsListRepositoryMock()
        navigation = BookmarkViewModelNavigation(navigateToDetail: mockNavigation.navigateToSafari)
        viewModel = BookmarkViewModel(navigation: navigation, newsRepo: mockRepository)
    }
    
    override func tearDown() {
        super.tearDown()
        mockNavigation = nil
        mockRepository = nil
        navigation = nil
        viewModel = nil
    }
    
    func testGetSavedArticlesSucces() {
        // Given
        mockRepository.savedArticles = NewsMock().mockNews.articles
        
        // When
        viewModel.fetchFromCoreData()
        
        // Then
        XCTAssertNotNil(viewModel.articles)
    }
}
