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
  func getMovies() {
    Task {
      do {
        movies = try await useCase.getMovies()
      } catch {
        errorMessage = error.localizedDescription
        print(error)
      }
    }
  }
}

