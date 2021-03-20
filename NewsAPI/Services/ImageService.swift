//
//  ImageService.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation
import SwiftUI

protocol ImageServiceProtocol {
    func load(_ image: LoadableSubject<UIImage>, url: URL?)
}

class ImageService: ImageServiceProtocol {
    static let shared = ImageService()
    
    private let webRepository = ImageRepository.shared
    private let cancelBag = CancelBag()
    
    func load(_ image: LoadableSubject<UIImage>, url: URL?) {
        guard let url = url else {
            image.wrappedValue = .notRequested
            return
        }

        image.wrappedValue.setIsLoading(cancelBag: cancelBag)

        webRepository
            .load(imageURL: url)
            .sinkToLoadable { image.wrappedValue = $0 }
            .store(in: cancelBag)
    }
}
