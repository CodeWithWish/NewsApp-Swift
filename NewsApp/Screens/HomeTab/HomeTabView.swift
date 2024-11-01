//
//  HomeTabView.swift
//  NewsApp
//
//  Created by Vidya Mulay on 28/10/24.
//

import Foundation
import SwiftUI

struct HomeTabView : View {
    
    var body: some View {
        TabView {
            // TopHeadLines
            let topContainer = NewsListContainer()
            let _ = topContainer.registerDependencies()
            let topCoordinator = NewsListCoordinator(container: topContainer)
            topCoordinator.getView()
                .tabItem {
                    Image(systemName: "globe")
                        .font(.system(size: 22))
                }
            
            // SortBy Category and Sources
            let sortContainer = SourcesAndCategoriesContainer()
            let _ = sortContainer.registerDependencies()
            let sortCoordinator = SourcesAndCategoriesCoordinator(container: sortContainer)
            sortCoordinator.getView()
                .tabItem {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 22))
                }
            
            // View Bookmarks
            let bookMarkContainer = BookmarkContainer()
            let _ = bookMarkContainer.registerDependencies()
            let bookMarkCoordinator = BookmarkCoordinator(container: bookMarkContainer)
            bookMarkCoordinator.getView()
                .tabItem {
                    Image(systemName: "bookmark")
                        .font(.system(size: 22))
                }
        }
    }
}
