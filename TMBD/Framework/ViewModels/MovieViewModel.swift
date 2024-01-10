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
  private var nowPage = 1
  private var upcomingPage = 1
  @Published var errorMessage: String?
  
  @Published var popularMovies: [Movie] = []
  @Published var topRatedMovies: [Movie] = []
  @Published var nowPlayingMovies: [Movie] = []
  @Published var upcomingMovies: [Movie] = []
  @Published var detailMovie: DetailMovie = DetailMovie(budget: 0, id: 0, production_companies: [], status: "", title: "", revenue: 0, runtime: 0)
  @Published var movieCredits: (cast: [Cast], crew: [Crew]) = ([], [])
  
  init(useCase: MovieUseCase = MovieUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  func getPopular() async {
    do {
      let resultMovie = try await useCase.getPopular(page: popularPage)
      if let resultMovie = resultMovie {
        popularMovies.append(contentsOf: resultMovie)
        popularPage += 1
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
  func getNowPlaying() async {
    do {
      let resultMovie = try await useCase.getNowPlaying(page: nowPage)
      if let resultMovie = resultMovie {
        nowPlayingMovies.append(contentsOf: resultMovie)
        nowPage += 1
      }
    } catch {
      errorMessage = "Failed to fetch top rated movies: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getUpcoming() async {
    do {
      let resultMovie = try await useCase.getUpcoming(page: upcomingPage)
      if let resultMovie = resultMovie {
        upcomingMovies.append(contentsOf: resultMovie)
        upcomingPage += 1
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
  
  @MainActor
  func getMovieCredits(id: Int) async {
    do {
      let (cast, crew) = try await useCase.getMovieCredits(id: id)
      movieCredits = (cast: movieCredits.cast + cast, crew: movieCredits.crew + crew)
    } catch {
      errorMessage = "Failed to fetch movie credits: \(error.localizedDescription)"
    }
  }
  
}


