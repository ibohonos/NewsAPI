//
//  NewsView.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import SwiftUI

struct NewsView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        Group {
            switch viewModel.news {
                case .notRequested: notRequestedView
                case .isLoading: loadingView
                case let .loaded(account): loadedView(account)
                case let .failed(error): failedView(error)
            }
        }
    }
}

// MARK: - Side Effects
private extension NewsView {
    func loadData() {
        viewModel.loadData($viewModel.news)
    }
}

// MARK: - Loading Content
private extension NewsView {
    var notRequestedView: some View {
        loadingView
            .onAppear(perform: loadData)
    }
    
    var loadingView: some View {
        ActivityIndicator(shouldAnimate: .constant(true))
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: loadData)
    }
}

// MARK: - Displaying Content
private extension NewsView {
    func loadedView(_ news: News) -> some View {
        NavigationView {
            List {
                ForEach(news.content, id: \.sectionTitle) { content in
                    Section(header: Text(content.sectionTitle)) {
                        if let texts = content.texts {
                            ForEach(texts, id: \.self) { text in
                                NavigationLink(destination: Text(text)) {
                                    Text(text)
                                }
                            }
                        }
                        
                        if let images = content.images {
                            ForEach(images, id: \.self) { image in
                                NavigationLink(destination: DetailImageView(url: image)) {
                                    ImageView(imageURL: image)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("News")
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
