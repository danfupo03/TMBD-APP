//
//  TVRepository.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import Foundation

struct TVApi {
  static let base = "https://api.themoviedb.org/3/tv"
  
  struct Routes {
    static let popularTV = "/popular"
  }
}

protocol TVApiProtocol {
  func getPopular(page: Int) async throws -> [TV]
}

class TVRepository: TVApiProtocol {
  let service: NetworkApiService
  static let shared = TVRepository()
  
  init(service: NetworkApiService = NetworkApiService.shared) {
    self.service = service
  }
  
  func getPopular(page: Int) async throws -> [TV] {
    let apiUrl = "\(TVApi.base)\(TVApi.Routes.popularTV)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return []
    }
    
    do {
      let response: TVResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching series: \(error)")
      throw error
    }
  }
  
  /// Helper method to construct the URL without the page parameter
  private func constructURL(apiUrl: String) -> URL? {
    let urlString = "\(apiUrl)?api_key=\(NetworkApiService.shared.apiKey)"
    return URL(string: urlString)
  }
  
  /// Helper method to construct the URL with the page parameter
  private func constructURL(apiUrl: String, page: Int) -> URL? {
    let urlString = "\(apiUrl)?api_key=\(NetworkApiService.shared.apiKey)&page=\(page)"
    return URL(string: urlString)
  }
}
