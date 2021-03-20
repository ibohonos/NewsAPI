//
//  ApiServise.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation
import Combine

class ApiServise: WebRepository {
    let session: URLSession
    var baseURL: String = "https://api.mocki.io/v1/"
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    static let shared = ApiServise()
    
    let newsRepository: NewsRepositoryProtocol
    
    init(session: URLSession = .shared, baseURL: String? = nil) {
        self.session = session

        if let baseURL = baseURL {
            self.baseURL = baseURL
        }
        
        newsRepository = NewsRepository(session: self.session, baseURL: self.baseURL)
    }
}

