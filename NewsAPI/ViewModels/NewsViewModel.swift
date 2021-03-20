//
//  NewsViewModel.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var news: Loadable<News> = .notRequested
    
    private let newsService = NewsService.shared
    
    func loadData(_ news: LoadableSubject<News>) {
        newsService
            .loadNews(news)
    }
}
