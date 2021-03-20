//
//  ImageWebRepository.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation
import Combine
import SwiftUI

struct ImageRepository {
    var session: URLSession
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    static let shared = ImageRepository()
    
    init() {
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        
        session = URLSession(configuration: configuration)
    }
    
    func load(imageURL: URL) -> AnyPublisher<UIImage, Error> {
        return download(rawImageURL: imageURL)
            .subscribe(on: bgQueue)
            .receive(on: DispatchQueue.main)
            .extractUnderlyingError()
            .eraseToAnyPublisher()
    }
    
    private func download(rawImageURL: URL, requests: [URLRequest] = []) -> AnyPublisher<UIImage, Error> {
        let url = rawImageURL
        let urlRequest = URLRequest(url: url)

        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) in
                guard let image = UIImage(data: data) else { throw APIError.imageProcessing(requests + [urlRequest]) }

                return image
            }
            .eraseToAnyPublisher()
    }
    
    private func removeCachedResponses(error: Error) -> AnyPublisher<UIImage, Error> {
        if let apiError = error as? APIError,
            case let .imageProcessing(urlRequests) = apiError,
            let cache = session.configuration.urlCache
        {
            urlRequests.forEach(cache.removeCachedResponse)
        }

        return Fail(error: error).eraseToAnyPublisher()
    }
}
