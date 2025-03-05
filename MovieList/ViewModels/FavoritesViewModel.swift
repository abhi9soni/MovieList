//
//  FavoritesViewModel.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import Foundation


class FavoritesViewModel {
    private let favoritesManager = FavoritesManager.shared
    var favoriteMovies: [Movie] = []

    func loadFavorites() {
        favoriteMovies = favoritesManager.getFavorites()
    }

    func toggleFavorite(movie: Movie) {
        if favoritesManager.isFavorite(movie: movie) {
            favoritesManager.removeFavorite(movie: movie)
        } else {
            favoritesManager.addFavorite(movie: movie)
        }
        loadFavorites()
    }
}
