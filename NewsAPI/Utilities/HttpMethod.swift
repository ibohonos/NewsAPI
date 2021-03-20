//
//  HttpMethod.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation

enum HttpMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}
 
extension HttpMethod {
    func getMethod() -> String {
        switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .patch: return "PATCH"
            case .delete: return "DELETE"
        }
    }
}
