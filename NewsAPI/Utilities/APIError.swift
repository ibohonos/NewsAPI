//
//  APIError.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case loginError
    case unexpectedResponse
    case imageProcessing([URLRequest])
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .invalidURL: return "Invalid URL"
            case let .httpCode(code): return "Unexpected HTTP code: \(code)"
            case .loginError: return "Need authorization"
            case .unexpectedResponse: return "Unexpected response from the server"
            case .imageProcessing: return "Unable to load image"
        }
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
    static let error = 400 ..< 500
}
