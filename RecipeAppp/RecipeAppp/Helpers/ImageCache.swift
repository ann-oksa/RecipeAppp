//
//  ImageCache.swift
//  RecipeAppp
//
//  Created by Hanna on 1/31/2025.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()

    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL?

    init() {
        cacheDirectory = try? fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }

    // Get image from cache
    func getImage(forKey key: String) -> UIImage? {
        if let image = memoryCache.object(forKey: key as NSString) {
            return image
        } else if let cacheDirectory, let diskImage = loadImageFromDisk(forKey: key) {
            memoryCache.setObject(diskImage, forKey: key as NSString)
            return diskImage
        }
        return nil
    }

    // Save image to cache
    func saveImage(_ image: UIImage, forKey key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        saveImageToDisk(image, forKey: key)
    }

    // Save image to disk
    private func saveImageToDisk(_ image: UIImage, forKey key: String) {
        guard let cacheDirectory else { return }
        let fileURL = cacheDirectory.appendingPathComponent(key)

        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: fileURL)
        }
    }

    // Load image from disk
    private func loadImageFromDisk(forKey key: String) -> UIImage? {
        guard let cacheDirectory else { return nil }
        let fileURL = cacheDirectory.appendingPathComponent(key)

        if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
}
