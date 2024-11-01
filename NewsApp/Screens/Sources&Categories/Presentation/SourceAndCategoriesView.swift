//
//  SourceAndCategoriesView.swift
//  NewsApp
//
//  Created by Vidya Mulay on 28/10/24.
//

import Foundation
import SwiftUI

struct SourceAndCategoriesView: View {
    @ObservedObject private var viewModel: SourcesAndCategoriesViewModel
    @State var category: String?
    
    var categories = NewsCategory.allCases.map { $0.rawValue }
    
    init(viewModel: SourcesAndCategoriesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                    .padding()
            } else {
                VStack(spacing: 0) {
                    Text("Categories")
                        .font(.headline)
                        .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack() {
                            ForEach(categories, id: \.self) { category in
                                NavigationLink(destination: viewModel.getCategoryNews(category: category)
                                    .navigationBarTitle(Text(category.capitalized))) {
                                        CategoryCell(category: category, imageString: viewModel.getIcon(for: NewsCategory(rawValue: category)))
                                    }
                            }
                        }
                        .padding()
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.15)
                    
                    Divider()
                        .background(Color.gray)
                        .padding(.horizontal)
                    
                    Text("Sources")
                        .font(.headline)
                        .padding()
                    
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                                ForEach(viewModel.sources, id: \.self) { source in
                                    NavigationLink(destination: viewModel.getSourceNews(source: source)
                                        .navigationBarTitle(Text(source.name?.capitalized ?? ""))) {
                                            SourceCell(name: source.name ?? "")
                                        }
                                }
                            }
                            .padding()
                            .frame(maxHeight: .infinity)
                        }
                    }
                }
            }
        }
        .toolbar(.visible, for: .tabBar)
        .onAppear() {
            Task {
                await self.viewModel.executeGetSources()
            }
        }
    }
}

struct CategoryCell: View {
    let category: String
    let imageString: String?
    
    var body: some View {
        VStack {
            Image(imageString ?? "business_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35) // Set the desired size
            
            Text(category.capitalized)
                .font(.subheadline)
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(8)
        }
        .frame(width: 135, height: 100)
    }
    
}

struct SourceCell: View {
    let name: String
    
    var body: some View {
        VStack {
            Text(name)
                .padding()
                .background(.white)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2) // Border
                )
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        }
    }
}
