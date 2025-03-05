//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Abhinav Soni on 04/03/25.
//

import Foundation
class MovieDetailViewModel {
    private let movieService = MovieService.shared
    var moviesDetail:MovieDetail?
   
    func movieDetailApi(movieId:String,completion: @escaping ((Bool) -> Void)){
        Task {
            do {
                let movies = try await movieService.movieDetail(endPoint: "\(Constants.Endpoints.movieDetails)\(movieId)")
                DispatchQueue.main.async {
                    self.moviesDetail = movies
                    completion(true)
                }
            } catch {
                completion(false)
                print("Error fetching movies: \(error)")
            }
        }
    }


}
