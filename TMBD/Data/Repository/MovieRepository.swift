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
    static let popularMovies = "/popular"
    static let topRatedMovies = "/top_rated"
  }
}

protocol MovieApiProtocol {
  func getPopular(page: Int) async throws -> [Movie]
  func getTopRated(page: Int) async throws -> [Movie]
  func getMovieDetail(id: Int) async throws -> DetailMovieModel
}

class MovieRepository: MovieApiProtocol {
  let service: NetworkApiService
  static let shared = MovieRepository()
  
  init(service: NetworkApiService = NetworkApiService.shared) {
    self.service = service
  }
  
  /// A function to get movies from the API
  /// - Parameter page: The page to get movies from
  /// - Returns: Returns an array of movies
  func getPopular(page: Int) async throws -> [Movie] {
    let apiUrl = "\(Api.base)\(Api.Routes.popularMovies)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return []
    }
    
    do {
      return try await service.get(url: url, method: .get)
    } catch {
      debugPrint("Error fetching movies: \(error)")
      throw error
    }
  }
  
  func getTopRated(page:Int) async throws -> [Movie] {
    let apiUrl = "\(Api.base)\(Api.Routes.topRatedMovies)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return[]
    }
    
    do {
      return try await service.get(url: url, method: .get)
    } catch {
      debugPrint("Error fetching movies: \(error)")
      throw error
    }
  }

  func getMovieDetail(id: Int) async throws -> DetailMovieModel {
    let apiUrl = "\(Api.base)/\(id)"
    let url = URL(string: apiUrl) ?? URL(string: "\(Api.base)/\(id)")!
    
    do {
      return try await service.get(url: url, method: .get)
    } catch {
      debugPrint("Error fetching movies: \(error)")
      throw error
    }
  }
  
  
  /// Helper method to construct the URL with the page parameter
  private func constructURL(apiUrl: String, page: Int) -> URL? {
    let urlString = "\(apiUrl)?api_key=\(NetworkApiService.shared.apiKey)&page=\(page)"
    return URL(string: urlString)
  }
}

