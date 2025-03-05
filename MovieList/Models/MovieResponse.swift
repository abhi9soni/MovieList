//
//  MovieResponse.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import Foundation

// MARK: - Movie Response Model
struct MovieResponse: Codable {
    let results: [Movie]
}
