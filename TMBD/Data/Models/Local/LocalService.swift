//
//  LocalService.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import Foundation

// swiftlint:disable:next identifier_name
let USER_KEY = "currentUser"

class LocalService {
  static let shared = LocalService()
  
  func getCurrentUser() -> String? {
    return UserDefaults.standard.string(forKey: USER_KEY)
  }
  
  func setCurrentUser(_ email: String) {
    UserDefaults.standard.set(email, forKey: USER_KEY)
  }
  
  func removeCurrentUser() {
    UserDefaults.standard.removeObject(forKey: USER_KEY)
  }
}
