//
//  PeopleUseCase.swift
//  TMBD
//
//  Created by Dan FuPo on 17/01/24.
//

import Foundation

protocol PeopleUseCaseProtocol {
  func getPopular(page: Int) async throws -> [People]?
}

class PeopleUseCase: PeopleUseCaseProtocol {
  let repository: PeopleRepository
  static let shared = PeopleUseCase()
  
  init(repository: PeopleRepository = PeopleRepository.shared) {
    self.repository = repository
  }
  
  func getPopular(page: Int) async throws -> [People]? {
    return try await repository.getPopular(page: page)
  }
}
