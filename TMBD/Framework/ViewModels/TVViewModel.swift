//
//  TVViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import Foundation

class TVViewModel: ObservableObject {
  private let useCase: TVUseCase
  
  private var popularPage = 1
  @Published var errorMessage: String?
  
  @Published var popularTV: [TV] = []
  
  init(useCase: TVUseCase = TVUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  func getPopular() async {
    do {
      let resultTV = try await useCase.getPopular(page: popularPage)
      if let resultTV = resultTV {
        popularTV.append(contentsOf: resultTV)
        popularPage += 1
      }
    } catch {
      errorMessage = "VM: Failed to fetch popular series: \(error.localizedDescription)"
    }
  }
}
