//
//  SourceAndCategoryViewModelTest.swift
//  NewsAppTests
//
//  Created by Vidya Mulay on 01/11/24.
//

import XCTest
@testable import NewsApp

final class SourceAndCategoryViewModelTest: XCTestCase {
    private var viewModel: SourcesAndCategoriesViewModel!
    private var mockNavigation: SAndCViewModelNavigationMock!
    private var mockRepository: NewsListRepositoryMock!
    private var navigation: SourcesAndCategoriesViewModelNavigation!

    override func setUp() {
        super.setUp()
        mockNavigation = SAndCViewModelNavigationMock()
        mockRepository = NewsListRepositoryMock()
        navigation = SourcesAndCategoriesViewModelNavigation(navigateToSourceArticles: mockNavigation.navigateToSourceArticles, navigateToCategoryArticles: mockNavigation.navigateToCategoryArticles)
        viewModel = SourcesAndCategoriesViewModel(navigation: navigation, newsRepo: mockRepository)
    }

    override func tearDown() {
        super.tearDown()
        mockNavigation = nil
        mockRepository = nil
        navigation = nil
        viewModel = nil
    }
    
    func testExecuteFetchSourcesSuccess() async {
        // Given
        mockRepository.mockSources = NewsMock().mockSources
        let expectation = self.expectation(description: "Successful fetch of top headlines")
        
        // When
        await viewModel.executeGetSources()
        
        // Then
        XCTAssertEqual(viewModel.sources.count, 1)
        XCTAssertEqual(viewModel.errorMessage, "")
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testExecuteFetchSourcesError() async {
        // Given
        mockRepository.mockError = NSError(domain: "unitTest", code: 401)
        let expectation = self.expectation(description: "Failure fetch of top headlines")
        
        // When
        await viewModel.executeGetSources()
        
        // Then
        XCTAssertEqual(viewModel.sources.count, 0)
        XCTAssertNotEqual(viewModel.errorMessage, "")
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testNavigationToSourceNews() {
        // Given
        mockNavigation.navigatedToSourceArticles = false
        
        //When
        let _ = viewModel.getSourceNews(source: (NewsMock().mockSources.sources?[0])!)
        
        //Then
        XCTAssertTrue(mockNavigation.navigatedToSourceArticles)
    }
    
    func testNavigationToCategoryNews() {
        // Given
        mockNavigation.navigatedToCategoryArticles = false
        
        //When
        let _ = viewModel.getCategoryNews(category: "")
        
        //Then
        XCTAssertTrue(mockNavigation.navigatedToCategoryArticles)
    }
    
    func testGetIcon() {
        // Given
        let mock = "business_icon"
        
        // When
        let imageString = viewModel.getIcon(for: .business)
        
        //Then
        XCTAssertEqual(mock, imageString)
    }
}

class SAndCViewModelNavigationMock {
    var navigatedToSourceArticles = false
    var navigatedToCategoryArticles = false
    
    func navigateToSourceArticles(_ source: Source) -> NewsFromSourceView? {
        navigatedToSourceArticles = true
        return nil
    }
    func navigateToCategoryArticles(_ category: String) -> NewsFromCategoryView? {
        navigatedToCategoryArticles = true
        return nil
    }
}
