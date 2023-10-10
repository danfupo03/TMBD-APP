//
//  MovieRepository.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation

struct Api {
  static let base = "https://api.themoviedb.org/3/movie"
  
  struct Routes {
    static let movies = "/popular"
    static let apiKey = "12e629d7051e2adf10c4ba97a9c12fcb"
  }
}

protocol MovieApiProtocol {
  func getMovies() async throws -> [Movie]
}

class MovieRepository: MovieApiProtocol {
  
  let service: NetworkApiService
  static let shared = MovieRepository()
  
  init(service: NetworkApiService = NetworkApiService.shared) {
    self.service = service
  }
  
  func getMovies() async throws -> [Movie] {
      let apiUrl = "\(Api.base)\(Api.Routes.movies)"
      print(apiUrl) // Make sure the URL is correct before making the request
      guard let url = URL(string: apiUrl) else {
          debugPrint("Invalid URL")
          return []
      }

      do {
          return try await service.getMovies(url: url)
      } catch {
          debugPrint("Error fetching movies: \(error)")
          throw error
      }
  }
}

