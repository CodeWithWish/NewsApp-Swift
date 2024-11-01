//
//  NewsFromSource.swift
//  NewsApp
//
//  Created by Vidya Mulay on 28/10/24.
//

import Foundation

import SwiftUI

struct NewsFromSourceView : View {
    @ObservedObject var viewModel: NewsFromSourceViewModel
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
        .navigationBarTitle(Text(viewModel.source.id?.capitalized ?? ""), displayMode: .inline)
        .onAppear {
            Task {
                await viewModel.executeNews(for: viewModel.source.id ?? "")
            }
        }
    }
    
    private var mainView: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    if let description = viewModel.source.description {
                        Text(verbatim: description)
                            .lineLimit(nil)
                            .frame(width: UIScreen.main.bounds.width - 32,
                                   height: 150,
                                   alignment: .center)
                    }
                    if let urlString = viewModel.source.url, let url = URL(string: urlString) {
                        Link("Click here to know more about \(viewModel.source.name ?? "")", destination: url)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
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

