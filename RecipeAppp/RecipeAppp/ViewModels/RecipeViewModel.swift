//
//  RecipeViewModel.swift
//  RecipeAppp
//
//  Created by Hanna on 1/31/2025.
//

import Foundation
import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    private let apiURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

    func fetchRecipes() {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: apiURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error. Please try again."
                }
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(RecipeResponse.self, from: data)
                DispatchQueue.main.async {
                    if decodedData.recipes.isEmpty {
                        self.errorMessage = "No recipes available."
                    } else {
                        self.recipes = decodedData.recipes
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Malformed data. Please try again."
                }
            }
        }

        task.resume()
    }
}
