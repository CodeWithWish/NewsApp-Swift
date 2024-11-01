//
//  ArticleRow.swift
//  NewsApp
//
//  Created by Vidya Mulay on 28/10/24.
//

import Foundation
import SwiftUI

struct NewsRow: View {
    @State var isSaved: Bool = false
    @State var shouldShowFav: Bool = true
    
    let article: Article
    let onRemoveFavorite: () -> Void
    
    var body: some View {
        ZStack {
            loadImage
                .aspectRatio(contentMode: .fit)
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.4)
            
            VStack {
                HStack {
                    Spacer()
                    if shouldShowFav {
                        Button(
                            action: {
                                markedFavourite(for: article)
                            },
                            label: {
                                Image(systemName: isSaved ? "book.fill": "book")
                                    .accentColor(Color.white)
                                    .imageScale(.large)
                            }
                        )
                        .frame(width: 50, height: 50)
                        .padding(8)
                    } else {
                        Button(
                            action: {
                                onRemoveFavorite()
                            },
                            label: {
                                Image(systemName: "trash")
                                    .accentColor(Color.white)
                                    .imageScale(.large)
                            }
                        )
                        .frame(width: 50, height: 50)
                        .padding(8)
                    }
                }
                .padding(.top, 16)
                Spacer()
                laodContent
            }
        }
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 8)
        .background(.black)
        .onAppear() {
            isSaved = article.isArticleSaved()
        }
    }
    
    private func markedFavourite(for article: Article) {
        if article.isArticleSaved() {
            article.deleteArticle()
            isSaved = false
        } else {
            article.saveToCoreData()
            isSaved = true
        }
    }
    
    private func removeFavourite(for article: Article) {
        article.deleteArticle()
    }
    
    private var loadImage: some View {
        AsyncImage(
            url: URL(string: article.urlToImage ?? ""),
            content: { image in
                image.resizable()
                    .frame(maxWidth: UIScreen.main.bounds.width - 32, maxHeight: 250)
            },
            placeholder: {
                ProgressView()
            }
        )
        .scaledToFit()
    }
    
    private var laodContent: some View {
        VStack {
            Text(verbatim: article.source?.name ?? "")
                .foregroundColor(.white)
                .font(.subheadline)
                .lineLimit(nil)
                .padding([.leading, .trailing])
                .frame(width: UIScreen.main.bounds.width - 64,
                       alignment: .bottomLeading)
            
            Text(verbatim: article.title ?? "")
                .foregroundColor(.white)
                .font(.headline)
                .lineLimit(nil)
                .padding([.leading, .trailing])
                .frame(width: UIScreen.main.bounds.width - 64,
                       alignment: .bottomLeading)
            
            Text(verbatim: article.publishedAt ?? "")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding([.leading, .bottom, .trailing])
                .frame(width: UIScreen.main.bounds.width - 64,
                       alignment: .bottomLeading)
        }
    }
}
