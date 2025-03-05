//
//  MovieService.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import Foundation

// MARK: - Movie Service (Singleton)
class MovieService {
    static let shared = MovieService()
    private let apiKey = Constants.apiKey
    private let baseUrl = Constants.baseUrl
    
    // MARK: - Fetch Movie List
    func movieList(endPoint: String) async throws -> [Movie] {
        let url = URL(string: "\(baseUrl)\(endPoint)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            // MARK: - Debugging: Print Raw API Response
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw API Response: \(jsonString)")
//            }
            let decoder = JSONDecoder()
            let movieResponse = try decoder.decode(MovieResponse.self, from: data)
            print("movieResponse-----: \(movieResponse)")
            return movieResponse.results

        } catch {
            print("Error fetching movies: \(error)")
            throw error
        }
    }
    // MARK: - Fetch Movie Details
    func movieDetail(endPoint: String) async throws -> MovieDetail {
        let url = URL(string: "\(baseUrl)\(endPoint)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US")
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        // MARK: - Debugging: Print Raw API Request
//        print("Raw API request:----- \(request)")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            // Debug: Print API Response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw API Response:---- \(jsonString)")
            }
            let decoder = JSONDecoder()
            let movieResponse = try decoder.decode(MovieDetail.self, from: data)
            print("movieResponse-----: \(movieResponse)")
            return movieResponse

        } catch {
            print("Error fetching movies: \(error)")
            throw error
        }
    }
    
}




