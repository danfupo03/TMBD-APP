//
//  TVViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import Foundation

class TVViewModel: ObservableObject {
  private let useCase: TVUseCase
  
  private var popularPage = 1
  private var topPage = 1
  private var airingPage = 1
  private var onAirPage = 1
  private var trendingPage = 1
  @Published var errorMessage: String?
  
  @Published var popularTV: [TV] = []
  @Published var topRatedTV: [TV] = []
  @Published var airingTV: [TV] = []
  @Published var onAirTV: [TV] = []
  @Published var trendingTV: [TV] = []
  @Published var detailTV: DetailTV = DetailTV(id: 0,
                                               created_by: [],
                                               episode_run_time: [],
                                               homepage: "",
                                               in_production: false,
                                               last_air_date: "",
                                               number_of_episodes: 0,
                                               number_of_seasons: 0,
                                               origin_country: [],
                                               original_language: "",
                                               production_companies: [],
                                               seasons: [Seasons(id: 0, episode_count: 0, name: "", overview: "", season_number: 0, vote_average: 0)],
                                               status: "",
                                               tagline: "",
                                               type: "")
  @Published var tvCredits: (cast: [Cast], crew: [Crew]) = ([], [])
  @Published var tvEpisodes: SeasonDetail = SeasonDetail(id: 0, air_date: "", episodes: [], name: "", overview: "", season_number: 0, vote_average: 0.0)
  
  init(useCase: TVUseCase = TVUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  func getPopular() async {
    do {
      let resultTV = try await useCase.getPopular(page: popularPage)
      if let resultTV = resultTV {
        popularTV.append(contentsOf: resultTV)
        popularPage += 1
      }
    } catch {
      errorMessage = "VM: Failed to fetch popular series: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getTopRated() async {
    do {
      let resultTV = try await useCase.getTopRated(page: topPage)
      if let resultTV = resultTV {
        topRatedTV.append(contentsOf: resultTV)
        topPage += 1
      }
    } catch {
      errorMessage = "VM: Failed to fetch popular series: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getAiringToday() async {
    do {
      let resultTV = try await useCase.getAiringToday(page: airingPage)
      if let resultTV = resultTV {
        airingTV.append(contentsOf: resultTV)
        airingPage += 1
      }
    } catch {
      errorMessage = "VM: Failed to fetch popular series: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getOnTheAir() async {
    do {
      let resultTV = try await useCase.getOnTheAir(page: onAirPage)
      if let resultTV = resultTV {
        onAirTV.append(contentsOf: resultTV)
        onAirPage += 1
      }
    } catch {
      errorMessage = "VM: Failed to fetch popular series: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getTrending(pages: Int) async {
    do {
      let resultTV = try await useCase.getTrending(page: trendingPage)
      if let resultTV = resultTV {
        trendingTV.append(contentsOf: resultTV)
        trendingPage += 1
      }
    } catch {
      errorMessage = "Failed to fetch popular series: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getTVDetail(id: Int) async throws {
    do {
      self.detailTV = try await useCase.getTVDetail(id: id)
    } catch {
      errorMessage = "Failed to fetch tv shows detail: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getTVCredits(id: Int, season: Int) async {
    do {
      let (cast, crew) = try await useCase.getTVCredits(id: id, season: season)
      tvCredits = (cast: tvCredits.cast + cast, crew: tvCredits.crew + crew)
    } catch {
      errorMessage = "Failed to fetch movie credits: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getEpisodes(id: Int, season: Int) async {
    do {
      self.tvEpisodes = try await useCase.getEpisodes(id: id, season: season)
    } catch {
      errorMessage = "Failed to fetch tv episodes: \(error.localizedDescription)"
    }
  }
}
