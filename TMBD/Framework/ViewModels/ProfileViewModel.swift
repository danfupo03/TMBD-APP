//
//  ProfileViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
  @Published var email = ""
  
  var useCase: UserUseCase
  
  init(useCase: UserUseCase = UserUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  func getCurrentUser() {
    self.email = self.useCase.getCurrentUser() ?? ""
  }
  
  @MainActor
  func logOut() {
    self.email = ""
    self.useCase.removeCurrentUser()
  }
}
