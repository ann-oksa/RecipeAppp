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
    private var currentURL: String = API.allRecipesURL  // Default URL

    func fetchRecipes(from url: String) async {
        isLoading = true
        errorMessage = nil
        currentURL = url  // Store current URL

        guard let requestURL = URL(string: url) else {
            errorMessage = ErrorMessages.networkError
            isLoading = false
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: requestURL)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }

            let decodedData = try JSONDecoder().decode(RecipeResponse.self, from: data)

            if decodedData.recipes.isEmpty {
                errorMessage = ErrorMessages.emptyData
                recipes = []
            } else {
                recipes = decodedData.recipes
            }
        } catch {
            errorMessage = ErrorMessages.malformedData
            recipes = []
        }

        isLoading = false
    }
}
