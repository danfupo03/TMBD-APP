//
//  ProfileViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
  @Published var email = ""
  
  var userRequirement: UserRequirementProtocol
  
  init(userRequirement: UserRequirementProtocol = UserRequirement.shared) {
    self.userRequirement = userRequirement
  }
  
  @MainActor
  func getCurrentUser() {
    self.email = self.userRequirement.getCurrentUser() ?? ""
  }
  
  @MainActor
  func logOut() {
    self.email = ""
    self.userRequirement.removeCurrentUser()
  }
}
