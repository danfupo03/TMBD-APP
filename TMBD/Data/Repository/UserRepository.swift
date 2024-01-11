//
//  UserRepository.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import Foundation

protocol UserServiceProtocol {
  func getCurrentUser() -> String?
  func setCurrentUser(email:String)
  func removeCurrentUser()
}

class UserRepository: UserServiceProtocol {
  static let shared = UserRepository()
  var localService = LocalService()
  
  init(localService: LocalService = LocalService.shared) {
    self.localService = localService
  }
  
  func getCurrentUser() -> String? {
    self.localService.getCurrentUser()
  }
  
  func setCurrentUser(email: String) {
    self.localService.setCurrentUser(email)
  }
  
  func removeCurrentUser() {
    self.localService.removeCurrentUser()
  }
}
