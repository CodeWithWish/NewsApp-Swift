//
//  NewsListView.swift
//  NewsApp
//
//  Created by Vidya Mulay on 26/10/24.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject private var viewModel: NewsListViewModel
    @State var articleURL: URL?
    @State private var isArticleSaved: Bool = false
    
    init(viewModel: NewsListViewModel, articleURL: URL? = nil) {
        self.viewModel = viewModel
        self.articleURL = articleURL
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    if viewModel.errorMessage != "" {
                        Text(viewModel.errorMessage)
                            .padding()
                    } else {
                        ForEach(viewModel.articles, id: \.self) { article in
                            NewsRow(article: article, onRemoveFavorite: {
                                reload()
                            })
                            .onTapGesture {
                                self.articleURL = URL(string: article.url ?? "" )
                            }
                        }
                    }
                }
            }
            .sheet(item: $articleURL) { url in
                viewModel.navigateToWebView(url: url)
            }
            .navigationBarTitle(Text("Top Headlines"))
            .navigationBarItems(trailing:
                                    Button(
                                        action: {
                                            reload()
                                        },
                                        label: {
                                            Text("Refresh")
                                                .foregroundColor(.black)
                                        }
                                    )
            )
        }
        .onAppear(perform: {
            reload()
        })
    }
    
    func reload() {
        Task {
            await self.viewModel.executeFetchTopHeadline()
        }
    }
}
