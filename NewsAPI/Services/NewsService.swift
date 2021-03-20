//
//  NewsService.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation
import SwiftUI

protocol NewsServiceProtocol {
    func loadNews(_ news: LoadableSubject<News>)
}

class NewsService: NewsServiceProtocol {
    static let shared = NewsService()

    private let apiService = ApiServise.shared
    private let cancelBag = CancelBag()
    
    func loadNews(_ news: LoadableSubject<News>) {
        news.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        apiService
            .newsRepository
            .getNews()
            .sinkToLoadable { content in
                print(content)
                
                withAnimation {
                    news.wrappedValue = content
                }
            }
            .store(in: cancelBag)
    }
}
