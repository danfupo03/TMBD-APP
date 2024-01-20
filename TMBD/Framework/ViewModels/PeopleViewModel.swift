//
//  PeopleViewModel.swift
//  TMBD
//
//  Created by Dan FuPo on 17/01/24.
//

import Foundation

class PeopleViewModel: ObservableObject {
  private let useCase: PeopleUseCase
  
  private var page = 1
  @Published var errorMessage: String?
  
  @Published var popularPeople: [People] = []
  @Published var detailPerson: DetailPeople = DetailPeople(id: 0,
                                                           biography: "",
                                                           birthday: "",
                                                           deathday: "",
                                                           place_of_birth: "")
  
  init(useCase: PeopleUseCase = PeopleUseCase.shared) {
    self.useCase = useCase
  }
  
  @MainActor
  func getPopular(pages: Int) async {
    do {
      for _ in 1...pages {
        let resultPerson = try await useCase.getPopular(page: page)
        if let resultPerson = resultPerson {
          popularPeople.removeAll()
          popularPeople.append(contentsOf: resultPerson)
        }
      }
    } catch {
      errorMessage = "Failed to fetch upcoming movies: \(error.localizedDescription)"
    }
  }
  
  @MainActor
  func getPerson(id: Int) async throws {
    do {
      self.detailPerson = try await useCase.getPerson(id: id)
    } catch {
      errorMessage = "Failed to fetch person detail: \(error.localizedDescription)"
    }
  }
}
