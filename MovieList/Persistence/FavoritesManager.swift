//
//  FavoritesManager.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import Foundation
import UIKit
import CoreData

// MARK: - Favorites Manager (Singleton)
class FavoritesManager {
    static let shared = FavoritesManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - Add Favorite Movie
    func addFavorite(movie: Movie) {
        let favorite = FavoriteMovie(context: context)
        favorite.title = movie.title
        favorite.releaseDate = movie.releaseDate
        favorite.posterPath = movie.posterPath
        favorite.movieId = Int64(movie.id)
        try? context.save()
    }
    // MARK: - Remove Favorite Movie
    func removeFavorite(movie: Movie) {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "movieId == %d", movie.id)
        if let result = try? context.fetch(fetchRequest), let objectToDelete = result.first {
            context.delete(objectToDelete)
            try? context.save()
        }
    }
    // MARK: - Check If Movie is Favorite
    func isFavorite(movie: Movie) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "movieId == %d", movie.id)
        return (try? context.fetch(fetchRequest).count) ?? 0 > 0
    }
    // MARK: - Get Favorite Movies
    func getFavorites() -> [Movie] {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.map { favorite in
                Movie( id: Int(favorite.movieId),
                       title: favorite.title ?? "Unknown Title",
                       adult: false,
                       originalTitle: favorite.title ?? "",
                       overview: "",
                       posterPath: favorite.posterPath ?? "",
                       backdropPath: favorite.backdropPath ?? "",
                       releaseDate: favorite.releaseDate ?? "",
                       voteAverage: 0,
                       voteCount: 0,
                       popularity: 0,
                       genreIDs: []
                )
              
            }
        } catch {
            print("Failed to fetch favorites: \(error)")
            return []
        }
    }

}
