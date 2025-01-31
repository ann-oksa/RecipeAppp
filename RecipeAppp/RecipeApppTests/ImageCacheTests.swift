//
//  ImageCacheTests.swift
//  RecipeApppTests
//
//  Created by Hanna on 1/31/2025.
//

import XCTest
@testable import RecipeAppp

final class ImageCacheTests: XCTestCase {
    var cache: ImageCache!
    var testImage: UIImage!
    let testKey = "testImageKey"

    override func setUp() {
        super.setUp()
        cache = ImageCache.shared
        testImage = UIImage(systemName: "star.fill")
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSaveAndGetImageFromMemoryCache() {
        guard let image = testImage else {
            XCTFail("Test image should not be nil")
            return
        }
        cache.saveImage(image, forKey: testKey)
        let cachedImage = cache.getImage(forKey: testKey)
        XCTAssertNotNil(cachedImage, "Image should be fetched from memory cache.")
        XCTAssertEqual(cachedImage?.pngData(), image.pngData(), "Fetched image should match the saved image.")
    }

    func testSaveAndGetImageFromDiskCache() {
        guard let image = testImage else {
            XCTFail("Test image should not be nil")
            return
        }
        cache.saveImage(image, forKey: testKey)
        let cachedImage = cache.getImage(forKey: testKey)
        XCTAssertNotNil(cachedImage, "Image should be fetched from disk cache after saving.")
        XCTAssertEqual(cachedImage?.pngData(), image.pngData(), "Fetched image should match the saved image.")
    }

    func testOverwriteImageInCache() {
        guard let image1 = testImage, let image2 = UIImage(systemName: "heart.fill") else {
            XCTFail("Test images should not be nil")
            return
        }
        cache.saveImage(image1, forKey: testKey)
        cache.saveImage(image2, forKey: testKey)
        let cachedImage = cache.getImage(forKey: testKey)
        
        XCTAssertNotNil(cachedImage, "Image should be fetched after overwriting.")
        XCTAssertEqual(cachedImage?.pngData(), image2.pngData(), "The cached image should be the second image after overwriting.")
    }

    func testLoadInvalidImageFromDisk() {
        let invalidImageData = Data("invalid".utf8)
        
        let cachedImage = cache.getImage(forKey: "invalidKey")
        XCTAssertNil(cachedImage, "Image should be nil for invalid data on disk.")
    }
}
