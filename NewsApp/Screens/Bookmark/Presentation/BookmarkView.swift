//
//  BookmarksView.swift
//  NewsApp
//
//  Created by Vidya Mulay on 31/10/24.
//

import Foundation
import SwiftUI

struct BookmarkView: View {
    @ObservedObject private var viewModel: BookmarkViewModel
    @State var articleURL: URL?
    
    init(viewModel: BookmarkViewModel, articleURL: URL? = nil) {
        self.viewModel = viewModel
        self.articleURL = articleURL
    }
    
    var body: some View {
        NavigationView {
            if let articles = viewModel.articles, articles.count > 0 {
            VStack(alignment: .center) {
                ScrollView {
                        ForEach(articles, id: \.self) { article in
                            NewsRow(shouldShowFav: false, article: article, onRemoveFavorite: {
                                article.deleteArticle()
                                viewModel.fetchFromCoreData()
                            })
                            .onTapGesture {
                                self.articleURL = URL(string: article.url ?? "" )
                            }
                        }
                    }
                }
            .sheet(item: $articleURL) { url in
                viewModel.navigateToWebView(url: url)
            }
            .navigationBarTitle(Text("My Bookmarks"))
            }
            else {
                Text("No bookmarks")
                    .padding()
            }
        }
        .onAppear(perform: {
            viewModel.fetchFromCoreData()
        })
        
    }
}
