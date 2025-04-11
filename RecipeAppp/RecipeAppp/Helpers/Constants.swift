//
//  Constants.swift
//  RecipeAppp
//
//  Created by Hanna on 1/31/2025.
//

import Foundation

struct API {
    static let allRecipesURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    static let malformedDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    static let emptyDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}

struct ErrorMessages {
    static let networkError = "Network error. Please try again."
    static let malformedData = "Malformed data. Please try again."
    static let emptyData = "No recipes available."
}
