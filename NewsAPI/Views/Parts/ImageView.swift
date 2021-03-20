//
//  ImageView.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import SwiftUI

struct ImageView: View {
    @StateObject private var viewModel = ImagesViewModel()
    let imageURL: URL?
    
    init(imageURL: String) {
        self.imageURL = URL(string: imageURL)
    }
    
    var body: some View {
        Group {
            switch viewModel.image {
                case .notRequested: notRequestedView
                case .isLoading: loadingView
                case let .loaded(image): loadedView(image)
                case let .failed(error): failedView(error)
            }
        }
    }
}

// MARK: - Side Effects
private extension ImageView {
    func loadImage() {
        viewModel.load(image: $viewModel.image, url: imageURL)
    }
}

// MARK: - Loading Content
private extension ImageView {
    var notRequestedView: some View {
        loadingView
            .onAppear(perform: loadImage)
    }
    
    var loadingView: some View {
        HStack {
            Spacer(minLength: 0)
            ActivityIndicator(shouldAnimate: .constant(true))
            Spacer(minLength: 0)
        }
    }
    
    func failedView(_ error: Error) -> some View {
        Text("Unable to load image")
            .font(.footnote)
            .multilineTextAlignment(.center)
            .padding()
    }
}

// MARK: - Displaying Content
private extension ImageView {
    func loadedView(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageURL: "https://www.collthings.co.uk/wp-content/uploads/2014/10/0UFstmn.jpg")
    }
}
