//
//  PeopleViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 17/01/24.
//

import Foundation

class PeopleViewModel: ObservableObject {
  private let useCase: PeopleUseCase
  
  private var popularPage = 1
  @Published var errorMessage: String?
  
  @Published var popularPeople: [People] = []
  
  init(useCase: PeopleUseCase = PeopleUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  func getPopular() async {
    do {
      let resultPeople = try await useCase.getPopular(page: popularPage)
      if let resultPeople = resultPeople {
        popularPeople.append(contentsOf: resultPeople)
        popularPage += 1
      }
    } catch {
      errorMessage = "VM: Failed to fetch popular people: \(error.localizedDescription)"
    }
  }
}
