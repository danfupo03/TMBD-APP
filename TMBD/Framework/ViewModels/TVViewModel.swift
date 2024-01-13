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
}
