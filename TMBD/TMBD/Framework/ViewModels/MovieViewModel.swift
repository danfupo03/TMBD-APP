//
//  MovieViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation

class MovieViewModel: ObservableObject {
  private let useCase: MovieUseCase
  
  @Published var movies: [Movie] = []
  @Published var errorMessage: String?
  
  init(useCase: MovieUseCase = MovieUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  func getMovies() async {
    do {
      let resultMovie = try await useCase.getMovies()
      if let resultMovie = resultMovie {
        movies = resultMovie
      }
    } catch {
      errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
    }
    
  }
}

