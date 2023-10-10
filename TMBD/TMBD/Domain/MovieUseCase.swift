//
//  MovieUseCase.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation

protocol MovieUseCaseProtocol {
  func getMovies() async throws -> [Movie]
}

class MovieUseCase: MovieUseCaseProtocol {
  let repository: MovieRepository
  static let shared = MovieUseCase()
  
  init(repository: MovieRepository = MovieRepository.shared) {
    self.repository = repository
  }
  
  func getMovies() async throws -> [Movie] {
    do {
      return try await repository.getMovies()
    } catch {
      print(error)
      throw error
      
    }
  }
}

