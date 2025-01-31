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
    private let apiURL = API.allRecipesURL
    
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
                    self.errorMessage = ErrorMessages.networkError
                }
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(RecipeResponse.self, from: data)
                DispatchQueue.main.async {
                    if decodedData.recipes.isEmpty {
                        self.errorMessage = ErrorMessages.emptyData
                    } else {
                        self.recipes = decodedData.recipes
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = ErrorMessages.malformedData
                }
            }
        }

        task.resume()
    }
}
