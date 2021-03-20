//
//  DetailImageView.swift
//  NewsAPI
//
//  Created by MacBook Pro on 20.03.2021.
//

import SwiftUI

struct DetailImageView: View {
    let url: String

    var body: some View {
        ZoomableScrollView {
            ImageView(imageURL: url)
        }
    }
}

struct DetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView(url: "https://www.collthings.co.uk/wp-content/uploads/2014/10/0UFstmn.jpg")
    }
}
