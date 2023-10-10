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
    static let apiKey = "?api_key=12e629d7051e2adf10c4ba97a9c12fcb"
  }
}

protocol MovieApiProtocol {
  func getMovies() async throws -> [Movie]?
}

class MovieRepository: MovieApiProtocol {
  
  let service: NetworkApiService
  static let shared = MovieRepository()
  
  init(service: NetworkApiService = NetworkApiService.shared) {
    self.service = service
  }
  
  func getMovies() async throws -> [Movie]? {
    let urlString = "\(Api.base)\(Api.Routes.movies)\(Api.Routes.apiKey)"
    guard let url = URL(string: urlString) else {
      throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
    }
  }
}

