//
//  UserUseCase.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import Foundation

import Foundation

protocol UserUseCaseProtocol {
  func getCurrentUser() -> String?
  func setCurrentUser(_ email: String)
  func removeCurrentUser()
}

class UserUseCase: UserUseCaseProtocol {
  static let shared = UserUseCase()
  let dataRepository: UserRepository
  
  init(dataRepository: UserRepository = UserRepository.shared) {
    self.dataRepository = dataRepository
  }
  
  func getCurrentUser() -> String? {
    return self.dataRepository.getCurrentUser()
  }
  
  func setCurrentUser(_ email: String) {
    self.dataRepository.setCurrentUser(email)
  }
  
  func removeCurrentUser() {
    self.dataRepository.removeCurrentUser()
  }
}
