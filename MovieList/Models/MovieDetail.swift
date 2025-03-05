//
//  MovieDetail.swift
//  MovieList
//
//  Created by Abhinav Soni on 04/03/25.
//

import Foundation

// MARK: - Movie Detail Model
struct MovieDetail: Codable, Identifiable {
    let id: Int?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let runtime: Int?
    let tagline: String?
    let status: String?
    let budget: Int?
    let revenue: Int?
    let homepage: String?
    let genres: [Genre]?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let spokenLanguages: [SpokenLanguage]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, tagline, status, budget, revenue, homepage, genres
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case spokenLanguages = "spoken_languages"
    }
}

// MARK: - Genre Model
struct Genre: Codable {
    let id: Int
    let name: String?
}

// MARK: - Production Company Model
struct ProductionCompany: Codable {
    let id: Int
    let name: String?
    let logoPath: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

// MARK: - Production Country Model
struct ProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - Spoken Language Model
struct SpokenLanguage: Codable {
    let iso639_1: String?
    let englishName: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case englishName = "english_name"
        case name
    }
}
