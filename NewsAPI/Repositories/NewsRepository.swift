//
//  NewsRepository.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation
import Combine

protocol NewsRepositoryProtocol: WebRepository {
    func getNews() -> AnyPublisher<News, Error>
}

struct NewsRepository: NewsRepositoryProtocol {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getNews() -> AnyPublisher<News, Error> {
        call(endpoint: API.get)
    }
}

extension NewsRepository {
    enum API {
        case get
    }
}

extension NewsRepository.API: APIRepository {
    var path: String {
        switch self {
            case .get: return "bb71653c"
        }
    }
    
    var method: HttpMethod {
        switch self {
            case .get: return .get
        }
    }
    
    var params: [String : Any] {
        switch self {
            case .get: return [:]
        }
    }
    
    var headers: [String : String]? {
        switch self {
            case .get: return [:]
        }
    }
    
    func body() throws -> Data? {
        if method != .get {
            return try JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        return nil
    }
}
