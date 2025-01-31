//
//  RecipeViewModelTests.swift
//  RecipeApppTests
//
//  Created by Hanna on 1/31/2025.
//

import XCTest
@testable import RecipeAppp

final class RecipeViewModelTests: XCTestCase {
    var viewModel: RecipeViewModel!

    override func setUp() async throws {
        await MainActor.run {
            viewModel = RecipeViewModel()
        }
    }

    override func tearDown() async throws {
        await MainActor.run {
            viewModel = nil
        }
    }

    @MainActor
    func testFetchRecipes_Success() async {
        await viewModel.fetchRecipes(from: API.allRecipesURL)
        
        XCTAssertFalse(viewModel.recipes.isEmpty, "Recipes should not be empty")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil")
    }

    @MainActor
    func testFetchRecipes_EmptyData() async {
        await viewModel.fetchRecipes(from: API.emptyDataURL)
        
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty")
        XCTAssertEqual(viewModel.errorMessage, ErrorMessages.emptyData, "Error message should show no recipes")
    }

    @MainActor
    func testFetchRecipes_MalformedData() async {
        await viewModel.fetchRecipes(from: API.malformedDataURL)
        
        XCTAssertTrue(viewModel.recipes.isEmpty, "Malformed data should be an empty recipe list.")
        XCTAssertEqual(viewModel.errorMessage, ErrorMessages.malformedData, "Error message should show malformed data.")
    }
}
