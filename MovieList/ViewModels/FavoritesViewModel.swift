//
//  FavoritesViewModel.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import Foundation

// MARK: - Favorites ViewModel
/// ViewModel responsible for managing favorite movies.
class FavoritesViewModel {
    private let favoritesManager = FavoritesManager.shared
    var favoriteMovies: [Movie] = []

    
    // MARK: - Load Favorite Movies
    /// Loads the favorite movies from `FavoritesManager` and updates the `favoriteMovies` array.
    func loadFavorites() {
        favoriteMovies = favoritesManager.getFavorites()
    }

    // MARK: - Toggle Favorite Status
        /// Adds or removes a movie from favorites based on its current status.
        ///
        /// - Parameter movie: The `Movie` object to toggle favorite status for.
    func toggleFavorite(movie: Movie) {
        if favoritesManager.isFavorite(movie: movie) {
            favoritesManager.removeFavorite(movie: movie)
        } else {
            favoritesManager.addFavorite(movie: movie)
        }
        loadFavorites()
    }
}
