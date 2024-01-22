//
//  PeopleUseCase.swift
//  TMBD
//
//  Created by Dan FuPo on 17/01/24.
//

import Foundation

protocol PeopleUseCaseProtocol {
  func getPopular(page: Int) async throws -> [People]?
  func getPerson(id: Int) async throws -> DetailPeople
}

class PeopleUseCase: PeopleUseCaseProtocol {
  let repository: PeopleRepository
  static let shared = PeopleUseCase()
  
  init(repository: PeopleRepository = PeopleRepository.shared) {
    self.repository = repository
  }
  
  /// Get popular people
  /// - Parameter page: Page number
  /// - Returns: People array
  func getPopular(page: Int) async throws -> [People]? {
    return try await repository.getPopular(page: page)
  }
  
  /// Get person details
  /// - Parameter id: DetailPeople object
  /// - Returns: DetailPeople object
  func getPerson(id: Int) async throws -> DetailPeople {
    return try await repository.getPerson(id: id)
  }
}
