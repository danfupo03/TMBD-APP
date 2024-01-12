//
//  LoginViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import Foundation

class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var messageAlert = ""
  @Published var showAlert = false
  
  var userRequirement: UserRequirementProtocol
  
  init(userRequirement: UserRequirementProtocol = UserRequirement.shared) {
    self.userRequirement = userRequirement
  }
  
  @MainActor
  func setCurrentUser() {
    if self.email != "" {
      self.userRequirement.setCurrentUser(email: self.email)
    } else {
      self.messageAlert = "Correo inválido"
      self.showAlert = true
    }
  }
  
  @MainActor
  func getCurrentUser() {
    self.email = self.userRequirement.getCurrentUser() ?? ""
  }
}
