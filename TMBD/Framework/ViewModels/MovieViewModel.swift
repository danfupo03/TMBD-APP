//
//  MovieViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation

class MovieViewModel: ObservableObject {
  private let useCase: MovieUseCase
  
  private var popularPage = 1
  private var topPage = 1
  @Published var errorMessage: String?
  
  @Published var popularMovies: [Movie] = []
  @Published var topRatedMovies: [Movie] = []
  @Published var detailMovie: DetailMovie = DetailMovie(budget: 0, id: 0, production_companies: [], status: "", title: "", revenue: 0, runtime: 0)
  
  init(useCase: MovieUseCase = MovieUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  /// A function to get movies from the API
  func getPopular() async {
    do {
      /// Fetch movies for the current page
      let resultMovie = try await useCase.getPopular(page: popularPage)
      if let resultMovie = resultMovie {
        popularMovies.append(contentsOf: resultMovie)
        popularPage += 1 /// Increment the current page number for the next fetch
      }
    } catch {
      errorMessage = "VM: Failed to fetch popular movies: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getTopRated() async {
    do {
      let resultMovie = try await useCase.getTopRated(page: topPage)
      if let resultMovie = resultMovie {
        topRatedMovies.append(contentsOf: resultMovie)
        topPage += 1
      }
    } catch {
      errorMessage = "Failed to fetch top rated movies: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getMovieDetail(id: Int) async throws {
      do {
          self.detailMovie = try await useCase.getMovieDetail(id: id)
      } catch {
          errorMessage = "Failed to fetch movie detail: \(error.localizedDescription)"
      }
  }
}


