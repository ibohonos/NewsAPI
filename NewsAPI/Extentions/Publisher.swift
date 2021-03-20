//
//  Publisher.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation
import Combine

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpCodes: HTTPCodes) -> AnyPublisher<Value, Error> where Value: Decodable {
        tryMap {
            assert(!Thread.isMainThread)
            Swift.print("url: \($0.1.url?.absoluteString ?? "nil")")
            Swift.print("statusCode: \(($0.1 as? HTTPURLResponse)?.statusCode ?? 0)")
//            Swift.print("data: \(String(data: $0.0, encoding: .utf8) ?? "nil")")

            guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }

            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }

            return $0.0
        }
        .extractUnderlyingError()
        .decode(type: Value.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
