//
//  MovieUseCase.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation

protocol MovieUseCaseProtocol {
  func getMovies(page: Int) async throws -> [Movie]?
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
  func getMovies(page: Int) async throws -> [Movie]? {
    return try await repository.getMovies(page: page)
  }
}

