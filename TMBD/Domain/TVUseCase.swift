//
//  TVUseCase.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import Foundation

protocol TVUseCaseProtocol {
  func getPopular() async throws -> [TV]?
  func getTopRated() async throws -> [TV]?
  func getAiringToday() async throws -> [TV]?
  func getOnTheAir() async throws -> [TV]?
  func getTrending() async throws -> [TV]?
  func getTVDetail(id: Int) async throws -> DetailTV
  func getTVCredits(id: Int, season: Int) async throws -> (cast: [Cast], crew: [Crew])
  func getEpisodes(id: Int, season: Int) async throws -> SeasonDetail
}

class TVUseCase: TVUseCaseProtocol {
  let repository: TVRepository
  static let shared = TVUseCase()
  
  init(repository: TVRepository = TVRepository.shared) {
    self.repository = repository
  }
  
  func getPopular() async throws -> [TV]? {
    return try await repository.getPopular()
  }
  
  func getTopRated() async throws -> [TV]? {
    return try await repository.getTopRated()
  }
  
  func getAiringToday() async throws -> [TV]? {
    return try await repository.getAiringToday()
  }
  
  func getOnTheAir() async throws -> [TV]? {
    return try await repository.getOnTheAir()
  }
  
  func getTrending() async throws -> [TV]? {
    return try await repository.getTrending()
  }
  
  func getTVDetail(id: Int) async throws -> DetailTV {
    return try await repository.getTVDetail(id: id)
  }
  
  func getTVCredits(id: Int, season: Int) async throws -> (cast: [Cast], crew: [Crew]) {
    return try await repository.getTVCredits(id: id, season: season)
  }
  
  func getEpisodes(id: Int, season: Int) async throws -> SeasonDetail {
    return try await repository.getEpisodes(id: id, season: season)
  }
}
