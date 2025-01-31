//
//  RecipeViewModel.swift
//  RecipeAppp
//
//  Created by Hanna on 1/31/2025.
//
import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: API.allRecipesURL) else {
            errorMessage = ErrorMessages.networkError
            isLoading = false
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }

            let decodedData = try JSONDecoder().decode(RecipeResponse.self, from: data)

            if decodedData.recipes.isEmpty {
                errorMessage = ErrorMessages.emptyData
            } else {
                recipes = decodedData.recipes
            }
        } catch {
            errorMessage = ErrorMessages.malformedData
        }

        isLoading = false
    }
}
