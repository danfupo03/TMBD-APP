//
//  PeopleRepository.swift
//  TMBD
//
//  Created by Dan FuPo on 17/01/24.
//

import Foundation

struct PeopleApi {
  static let base = "https://api.themoviedb.org/3/person"
  
  struct Routes {
    static let popularPeople = "/popular"
  }
}

protocol PeopleApiProtocol {
  func getPopular(page: Int) async throws -> [People]
  func getPerson(id: Int) async throws -> DetailPeople
}

class PeopleRepository: PeopleApiProtocol {
  let service: NetworkApiService
  static let shared = PeopleRepository()
  
  init(service: NetworkApiService = NetworkApiService.shared) {
    self.service = service
  }
  
  /// Get popular people
  /// - Parameter page: Page number
  /// - Returns: Array of people
  func getPopular(page: Int) async throws -> [People] {
    let apiUrl = "\(PeopleApi.base)\(PeopleApi.Routes.popularPeople)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return []
    }
    
    do {
      let response: PeopleResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching popular people: \(error)")
      throw error
    }
  }
  
  /// Get person details
  /// - Parameter id: Person id
  /// - Returns: DetailPeople object
  func getPerson(id: Int) async throws -> DetailPeople {
    let apiUrl = "\(PeopleApi.base)/\(id)"
    guard let url = constructURL(apiUrl: apiUrl) else {
      debugPrint("Rep: Invalid URL")
      throw NetworkError.invalidURL
    }
    
    do {
      return try await service.get(url: url, method: .get)
    } catch {
      debugPrint("Rep: Error fetching person details: \(error)")
      throw error
    }
  }
  
  /// Method to construct URL
  /// - Parameter apiUrl: API URL
  /// - Returns: The constructed URL
  private func constructURL(apiUrl: String) -> URL? {
    let urlString = "\(apiUrl)?api_key=\(NetworkApiService.shared.apiKey)"
    return URL(string: urlString)
  }
  
  
  /// Method to construct URL with page number
  /// - Parameters:
  ///   - apiUrl: API URL
  ///   - page: Page number
  /// - Returns: The constructed URL
  private func constructURL(apiUrl: String, page: Int) -> URL? {
    let urlString = "\(apiUrl)?api_key=\(NetworkApiService.shared.apiKey)&page=\(page)"
    return URL(string: urlString)
  }
}
