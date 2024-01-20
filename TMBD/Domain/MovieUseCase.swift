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
  
  /// A function to get movies from the API
  /// - Parameter page: The page to get movies from
  /// - Returns: Returns an array of movies
  func getPopular() async throws -> [Movie]? {
    return try await repository.getPopular()
  }
  
  func getTopRated() async throws -> [Movie]? {
    return try await repository.getTopRated()
  }
  
  func getNowPlaying() async throws -> [Movie]? {
    return try await repository.getNowPlaying()
  }
  
  func getUpcoming(page: Int) async throws -> [Movie]? {
    return try await repository.getUpcoming(page: page)
  }
  
  func getTrending() async throws -> [Movie]? {
    return try await repository.getTrending()
  }
  
  func getMovieDetail(id: Int) async throws -> DetailMovie {
    return try await repository.getMovieDetail(id: id)
  }
  
  func getMovieCredits(id: Int) async throws -> (cast: [Cast], crew: [Crew]) {
    return try await repository.getMovieCredits(id: id)
  }
  
}

