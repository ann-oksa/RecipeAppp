//
//  RecipeModel.swift
//  RecipeAppp
//
//  Created by Hanna on 1/31/2025.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    let id: UUID
    let name: String
    let cuisine: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name, cuisine
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}
