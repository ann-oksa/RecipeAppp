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
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.recipes) { recipe in
                        HStack {
                            if let photoURL = recipe.photoURLSmall,
                               let url = URL(string: photoURL) {
                                AsyncImage(url: url) { image in
                                    image.resizable().scaledToFill()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            }

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

                Button(action: {
                    viewModel.fetchRecipes()
                }) {
                    Text("Refresh Recipes")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .onAppear {
                viewModel.fetchRecipes()
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipeListView()
}
