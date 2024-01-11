//
//  MovieRepository.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation

struct Api {
  static let base = "https://api.themoviedb.org/3/movie"
  static let baseT = "https://api.themoviedb.org/3/trending/movie"
  
  struct Routes {
    static let popularMovies = "/popular"
    static let topRatedMovies = "/top_rated"
    static let nowPlayingMovies = "/now_playing"
    static let upcomingMovies = "/upcoming"
    static let trendingToday = "/day"
  }
}

protocol MovieApiProtocol {
  func getPopular(page: Int) async throws -> [Movie]
  func getTopRated(page: Int) async throws -> [Movie]
  func getNowPlaying(page: Int) async throws -> [Movie]
  func getUpcoming(page: Int) async throws -> [Movie]
  func getMovieDetail(id: Int) async throws -> DetailMovie
  func getMovieCredits(id: Int) async throws -> (cast: [Cast], crew: [Crew])
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
      let response: MovieResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching movies: \(error)")
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
      let response: MovieResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching movies: \(error)")
      throw error
    }
  }
  
  func getNowPlaying(page:Int) async throws -> [Movie] {
    let apiUrl = "\(Api.base)\(Api.Routes.nowPlayingMovies)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return[]
    }
    
    do {
      let response: MovieResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching movies: \(error)")
      throw error
    }
  }
  
  func getUpcoming(page:Int) async throws -> [Movie] {
    let apiUrl = "\(Api.base)\(Api.Routes.upcomingMovies)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return[]
    }
    
    do {
      let response: MovieResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching movies: \(error)")
      throw error
    }
  }
  
  func getMovieDetail(id: Int) async throws -> DetailMovie {
    let apiUrl = "\(Api.base)/\(id)"
    guard let url = constructURL(apiUrl: apiUrl) else {
      debugPrint("Rep: Invalid URL")
      throw NetworkError.invalidURL
    }
    
    do {
      return try await service.get(url: url, method: .get)
    } catch {
      debugPrint("Rep: Error fetching movie details: \(error)")
      throw error
    }
  }
  
  func getMovieCredits(id: Int) async throws -> (cast: [Cast], crew: [Crew]) {
    let apiUrl = "\(Api.base)/\(id)/credits"
    guard let url = constructURL(apiUrl: apiUrl) else {
      debugPrint("Rep: Invalid URL")
      return ([], [])
    }
    
    do {
      let response: CreditResponse = try await service.get(url: url, method: .get)
      return (response.cast, response.crew)
    } catch {
      debugPrint("Rep: Error fetching credits: \(error)")
      throw error
    }
  }
  
  /// Helper method to construct the URL without the page parameter
  private func constructURL(apiUrl: String) -> URL? {
    let urlString = "\(apiUrl)?api_key=\(NetworkApiService.shared.apiKey)"
    return URL(string: urlString)
  }
  
  /// Helper method to construct the URL with the page parameter
  private func constructURL(apiUrl: String, page: Int) -> URL? {
    let urlString = "\(apiUrl)?api_key=\(NetworkApiService.shared.apiKey)&page=\(page)"
    return URL(string: urlString)
  }
}

