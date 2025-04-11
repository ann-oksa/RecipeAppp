//
//  AsyncImageLoader.swift
//  RecipeAppp
//
//  Created by Hanna on 1/31/2025.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String?
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .onAppear {
                        Task {
                            await loadImage()
                        }
                    }
            }
        }
        .frame(width: 50, height: 50)
        .cornerRadius(8)
    }

    private func loadImage() async {
        guard let urlString = url, let imageURL = URL(string: urlString) else { return }
        
        let cacheKey = urlString.replacingOccurrences(of: "/", with: "_")

        if let cachedImage = ImageCache.shared.getImage(forKey: cacheKey) {
            image = cachedImage
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            if let downloadedImage = UIImage(data: data) {
                ImageCache.shared.saveImage(downloadedImage, forKey: cacheKey)
                await MainActor.run { image = downloadedImage }
            }
        } catch {
            print("Image loading failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    AsyncImageView(url: "")
}
