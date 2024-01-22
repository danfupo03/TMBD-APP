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
  
  /// Get popular tv shows
  /// - Returns: Array of tv shows
  func getPopular() async throws -> [TV]? {
    return try await repository.getPopular()
  }
  
  /// Get top rated tv shows
  /// - Returns:Array of tv shows
  func getTopRated() async throws -> [TV]? {
    return try await repository.getTopRated()
  }
  
  /// Get airing today tv shows
  /// - Returns: Array of tv shows
  func getAiringToday() async throws -> [TV]? {
    return try await repository.getAiringToday()
  }
  
  /// Get on the air tv shows
  /// - Returns: Array of tv shows
  func getOnTheAir() async throws -> [TV]? {
    return try await repository.getOnTheAir()
  }
  
  /// Get trending tv shows
  /// - Returns: Array of tv shows
  func getTrending() async throws -> [TV]? {
    return try await repository.getTrending()
  }
  
  /// Get tv show details
  /// - Parameter id: TV show id
  /// - Returns: DetailTV object
  func getTVDetail(id: Int) async throws -> DetailTV {
    return try await repository.getTVDetail(id: id)
  }
  
  /// Get tv show credits
  /// - Parameters:
  ///   - id: Tv show id
  ///   - season: Season number
  /// - Returns: Tuple of cast and crew
  func getTVCredits(id: Int, season: Int) async throws -> (cast: [Cast], crew: [Crew]) {
    return try await repository.getTVCredits(id: id, season: season)
  }
  
  /// Get season details
  /// - Parameters:
  ///   - id: Tv show id
  ///   - season: Season number
  /// - Returns: SeasonDetail object
  func getEpisodes(id: Int, season: Int) async throws -> SeasonDetail {
    return try await repository.getEpisodes(id: id, season: season)
  }
}
