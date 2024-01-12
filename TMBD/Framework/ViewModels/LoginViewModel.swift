//
//  LoginViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import Foundation

class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var messageAlert = ""
  @Published var showAlert = false
  @Published var password = ""
  
  var useCase: UserUseCaseProtocol
  
  init(useCase: UserUseCaseProtocol = UserUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  func getCurrentUser() {
    self.email = self.useCase.getCurrentUser() ?? ""
  }
  
  @MainActor
  func setCurrentUser() {
    if email.isEmpty {
      self.messageAlert = "Correo inválido"
      self.showAlert = true
    } else {
      self.useCase.setCurrentUser(self.email)
    }
  }
}
