//
//  Movie.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import Foundation


struct Movie: Codable {
    let id: Int
    let title: String?
    let adult: Bool?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let popularity: Double?
    let genreIDs: [Int]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case adult
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case genreIDs = "genre_ids"
    }
}
