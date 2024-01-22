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
  func getPopular() async {
    do {
      let resultPeople = try await useCase.getPopular(page: page)
      if let resultPeople = resultPeople {
        popularPeople.removeAll()
        popularPeople.append(contentsOf: resultPeople)
      }
    } catch {
      errorMessage = "Failed to fetch popular people: \(error.localizedDescription)"
    }
  }
  
  func goBack() {
    if page > 1 {
      page -= 1
      Task {
        await getPopular()
      }
    }
  }
  
  func goNext() {
    page += 1
    Task {
      await getPopular()
    }
  }
  
  func resetPage() {
    page = 1
    Task {
      await getPopular()
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
