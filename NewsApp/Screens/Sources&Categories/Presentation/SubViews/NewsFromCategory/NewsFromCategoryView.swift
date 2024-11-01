//
//  NewsFromCategory.swift
//  NewsApp
//
//  Created by Vidya Mulay on 29/10/24.
//

import Foundation
import SwiftUI

struct NewsFromCategoryView: View {
    @ObservedObject var viewModel: NewsFromCategoryViewModel
    @State var articleURL: URL?
    
    var body: some View {
        NavigationView {
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                    .padding()
            } else {
                mainView
                    .sheet(item: $articleURL) { url in
                        viewModel.navigateToWebView(url: url)
                    }
            }
        }
        .onAppear(perform: {
            Task {
                await self.viewModel.executeNews()
            }
        })
    }
    
    private var mainView: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    ForEach(viewModel.articles, id: \.self) { article in
                        NewsRow(article: article, onRemoveFavorite: {})
                            .onTapGesture {
                                self.articleURL = URL(string: article.url ?? "")
                            }
                    }
                }
            }
            .clipped()
        }
    }
}

