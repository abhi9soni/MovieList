//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import Foundation


class MovieViewModel {
    private let movieService = MovieService.shared
    var movies = [Movie]()
   

    func searchMovies(completion: @escaping ((Bool) -> Void)){
        Task {
            do {
                let movies = try await movieService.movieList(endPoint: Constants.Endpoints.nowPlaying)
                DispatchQueue.main.async {
                    self.movies = movies
                    completion(true)
                }
            } catch {
                completion(false)
                print("Error fetching movies: \(error)")
            }
        }
    }

}
