//
//  UserUseCase.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import Foundation

protocol UserRequirementProtocol {
  func setCurrentUser(email: String)
  func getCurrentUser() -> String?
  func removeCurrentUser()
}

class UserRequirement: UserRequirementProtocol {
  static let shared = UserRequirement()
  let dataRepository: UserRepository
  
  init(dataRepository: UserRepository = UserRepository.shared) {
    self.dataRepository = dataRepository
  }
  
  func setCurrentUser(email: String) {
    self.dataRepository.setCurrentUser(email: email)
  }
  
  func getCurrentUser() -> String? {
    return self.dataRepository.getCurrentUser()
  }
  
  func removeCurrentUser() {
    self.dataRepository.removeCurrentUser()
  }
}
