//
//  RecipeListView.swift
//  RecipeAppp
//
//  Created by Hanna on 1/31/2025.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                        .frame(maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text(errorMessage)
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding()
                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List(viewModel.recipes) { recipe in
                        HStack {
                            AsyncImageView(url: recipe.photoURLSmall)
                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.headline)
                                Text(recipe.cuisine)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }

                // Fixed buttons at the bottom
                HStack {
                    fetchButton(title: "All Recipes", url: API.allRecipesURL)
                    fetchButton(title: "Broken Data", url: API.malformedDataURL)
                    fetchButton(title: "Empty Data", url: API.emptyDataURL)
                }
                .padding()
                .background(Color(.systemGray6))
            }
            .onAppear {
                Task {
                    await viewModel.fetchRecipes(from: API.allRecipesURL)
                }
            }
            .navigationTitle("Recipes")
        }
    }

    // Reusable button for API selection
    private func fetchButton(title: String, url: String) -> some View {
        Button(action: {
            Task {
                await viewModel.fetchRecipes(from: url)
            }
        }) {
            Text(title)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    RecipeListView()
}
