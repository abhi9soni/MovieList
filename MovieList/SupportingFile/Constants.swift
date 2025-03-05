//
//  Constants.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import Foundation

struct Constants {    
    static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNzhlNmQyMjIyODkwM2VlNjZhMWM4MDFiNTkzMWM2NyIsIm5iZiI6MTc0MTAxNDQ4Ny4zNDksInN1YiI6IjY3YzVjNWQ3NTY0ZDI1NzVkOTkyMWE3ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ilq0awPDeR4PSiAPRABck8PL6NXA49ahjEnBl6t7zWE"
    static let baseUrl = "https://api.themoviedb.org/3/"
    
    struct Endpoints {
        static let movieDetails = "movie/"
        static let nowPlaying = "movie/now_playing"
    }
    
    struct ErrorMessages {
        static let networkError = "Unable to fetch data. Please check your internet connection."
        static let parsingError = "Failed to parse response data."
        static let unknownError = "Something went wrong. Please try again."
    }
}
