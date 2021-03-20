//
//  News.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation

// MARK: - News
struct News: Codable {
    let content: [NewsContent]
}

// MARK: - Content
struct NewsContent: Codable {
    let texts: [String]?
    let sectionTitle: String
    let images: [String]?
}
