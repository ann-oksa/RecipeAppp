//
//  AsyncImageLoader.swift
//  RecipeAppp
//
//  Created by Hanna on 1/31/2025.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String?
    
    var body: some View {
        if let urlString = url, let imageURL = URL(string: urlString) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .scaledToFill()
                case .failure(_):
                    placeholderImage
                case .empty:
                    ProgressView()
                @unknown default:
                    placeholderImage
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)
        } else {
            placeholderImage
        }
    }

    private var placeholderImage: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(.gray)
    }
}

#Preview {
    AsyncImageView(url: "")
}
