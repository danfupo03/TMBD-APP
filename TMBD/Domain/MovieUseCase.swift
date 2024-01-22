//
//  MovieUseCase.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation

protocol MovieUseCaseProtocol {
  func getPopular() async throws -> [Movie]?
  func getTopRated() async throws -> [Movie]?
  func getNowPlaying() async throws -> [Movie]?
  func getUpcoming(page: Int) async throws -> [Movie]?
  func getTrending() async throws -> [Movie]?
  func getMovieDetail(id: Int) async throws -> DetailMovie
  func getMovieCredits(id: Int) async throws -> (cast: [Cast], crew: [Crew])
}

class MovieUseCase: MovieUseCaseProtocol {
  let repository: MovieRepository
  static let shared = MovieUseCase()
  
  init(repository: MovieRepository = MovieRepository.shared) {
    self.repository = repository
  }
  
  /// Get popular movies
  /// - Returns: Movies array
  func getPopular() async throws -> [Movie]? {
    return try await repository.getPopular()
  }
  
  /// Get top rated movies
  /// - Returns: Movies array
  func getTopRated() async throws -> [Movie]? {
    return try await repository.getTopRated()
  }
  
  /// Get now playing movies
  /// - Returns: Movies array
  func getNowPlaying() async throws -> [Movie]? {
    return try await repository.getNowPlaying()
  }
  
  /// Get upcoming movies
  /// - Parameter page: <#page description#>
  /// - Returns: Movies array
  func getUpcoming(page: Int) async throws -> [Movie]? {
    return try await repository.getUpcoming(page: page)
  }
  
  /// Get trending movies
  /// - Returns: Movies array
  func getTrending() async throws -> [Movie]? {
    return try await repository.getTrending()
  }
  
  /// Get movie details
  /// - Parameter id: Movie id
  /// - Returns: DetailMovie object
  func getMovieDetail(id: Int) async throws -> DetailMovie {
    return try await repository.getMovieDetail(id: id)
  }
  
  /// Get movie credits
  /// - Parameter id: Movie id
  /// - Returns: Tuple of cast and crew
  func getMovieCredits(id: Int) async throws -> (cast: [Cast], crew: [Crew]) {
    return try await repository.getMovieCredits(id: id)
  }
  
}

