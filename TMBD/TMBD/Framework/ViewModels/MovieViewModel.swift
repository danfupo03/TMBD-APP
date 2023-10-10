//
//  MovieViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation

class MovieViewModel: ObservableObject {
  private let useCase: MovieUseCase
  private var currentPage = 1 // Keep track of the current page number
  @Published var movies: [Movie] = []
  @Published var errorMessage: String?
  
  init(useCase: MovieUseCase = MovieUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  func getMovies() async {
    do {
      // Fetch movies for the current page
      let resultMovie = try await useCase.getMovies(page: currentPage)
      if let resultMovie = resultMovie {
        movies.append(contentsOf: resultMovie)
        currentPage += 1 // Increment the current page number for the next fetch
      }
    } catch {
      errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
    }
  }
}


