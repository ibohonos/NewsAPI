//
//  ImagesViewModel.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import Foundation
import SwiftUI

class ImagesViewModel: ObservableObject {
    @Published var image: Loadable<UIImage> = .notRequested
    
    private let imageService = ImageService.shared

    func load(image: LoadableSubject<UIImage>, url: URL?) {
        imageService
            .load(image, url: url)
    }
}
