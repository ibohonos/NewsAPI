//
//  APIRepository.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation

protocol APIRepository {
    var path: String { get }
    var method: HttpMethod { get }
    var params: [String: Any] { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

extension APIRepository {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = []

        if method == .get {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value as? String))
            }
        }
        
        guard let compURL = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: compURL)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = method.getMethod()
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()

        return request
    }
}
