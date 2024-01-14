//
//  TVUseCase.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import Foundation

protocol TVUseCaseProtocol {
  func getPopular(page: Int) async throws -> [TV]?
  func getTopRated(page: Int) async throws -> [TV]?
  func getAiringToday(page: Int) async throws -> [TV]?
  func getOnTheAir(page: Int) async throws -> [TV]?
  func getTrending(page: Int) async throws -> [TV]?
  func getTVDetail(id: Int) async throws -> DetailTV
  func getTVCredits(id: Int, season: Int) async throws -> (cast: [Cast], crew: [Crew])
}

class TVUseCase: TVUseCaseProtocol {
  let repository: TVRepository
  static let shared = TVUseCase()
  
  init(repository: TVRepository = TVRepository.shared) {
    self.repository = repository
  }
  
  func getPopular(page: Int) async throws -> [TV]? {
    return try await repository.getPopular(page: page)
  }
  
  func getTopRated(page: Int) async throws -> [TV]? {
    return try await repository.getTopRated(page: page)
  }
  
  func getAiringToday(page: Int) async throws -> [TV]? {
    return try await repository.getAiringToday(page: page)
  }
  
  func getOnTheAir(page: Int) async throws -> [TV]? {
    return try await repository.getOnTheAir(page: page)
  }
  
  func getTrending(page: Int) async throws -> [TV]? {
    return try await repository.getTrending(page: page)
  }
  
  func getTVDetail(id: Int) async throws -> DetailTV {
    return try await repository.getTVDetail(id: id)
  }
  
  func getTVCredits(id: Int, season: Int) async throws -> (cast: [Cast], crew: [Crew]) {
    return try await repository.getTVCredits(id: id, season: season)
  }
}
