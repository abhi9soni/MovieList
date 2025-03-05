//
//  NetworkError.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL. Please try again."
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to decode response from server."
        case .serverError(let message):
            return message
        }
    }
}

