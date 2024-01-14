//
//  TVRepository.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import Foundation

struct TVApi {
  static let base = "https://api.themoviedb.org/3/tv"
  static let baseT = "https://api.themoviedb.org/3/trending/tv"
  
  struct Routes {
    static let popularTV = "/popular"
    static let topRatedTV = "/top_rated"
    static let airingTodayTV = "/airing_today"
    static let onTheAirTV = "/on_the_air"
    static let trendingToday = "/day"
  }
}

protocol TVApiProtocol {
  func getPopular(page: Int) async throws -> [TV]
  func getTopRated(page: Int) async throws -> [TV]
  func getAiringToday(page: Int) async throws -> [TV]
  func getOnTheAir(page: Int) async throws -> [TV]
  func getTrending(page: Int) async throws -> [TV]
  func getTVDetail(id: Int) async throws -> DetailTV
  func getTVCredits(id: Int, season: Int) async throws -> (cast: [Cast], crew: [Crew])
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
      debugPrint("Rep: Error fetching popular tv shows: \(error)")
      throw error
    }
  }
  
  func getTopRated(page: Int) async throws -> [TV] {
    let apiUrl = "\(TVApi.base)\(TVApi.Routes.topRatedTV)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return[]
    }
    
    do {
      let response: TVResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching top rated tv shows: \(error)")
      throw error
    }
  }
  
  func getAiringToday(page: Int) async throws -> [TV] {
    let apiUrl = "\(TVApi.base)\(TVApi.Routes.airingTodayTV)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return[]
    }
    
    do {
      let response: TVResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching airing today tv shows: \(error)")
      throw error
    }
  }
  
  func getOnTheAir(page: Int) async throws -> [TV] {
    let apiUrl = "\(TVApi.base)\(TVApi.Routes.onTheAirTV)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return[]
    }
    
    do {
      let response: TVResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching on the air tv shows: \(error)")
      throw error
    }
  }
  
  func getTrending(page: Int) async throws -> [TV] {
    let apiUrl = "\(TVApi.baseT)\(TVApi.Routes.trendingToday)"
    guard let url = constructURL(apiUrl: apiUrl, page: page) else {
      debugPrint("Invalid URL")
      return[]
    }
    
    do {
      let response: TVResponse = try await service.get(url: url, method: .get)
      return response.results
    } catch {
      debugPrint("Rep: Error fetching trending tv shows: \(error)")
      throw error
    }
  }
  
  func getTVDetail(id: Int) async throws -> DetailTV {
    let apiURL = "\(TVApi.base)/\(id)"
    guard let url = constructURL(apiUrl: apiURL) else {
      debugPrint("Rep: Invalid URL")
      throw NetworkError.invalidURL
    }
    
    do {
      return try await service.get(url: url, method: .get)
    } catch {
      debugPrint("Rep: Error fetching tv show details: \(error)")
      throw error
    }
  }
  
  func getTVCredits(id: Int, season: Int) async throws -> (cast: [Cast], crew: [Crew]) {
    let apiUrl = "\(TVApi.base)/\(id)/season/\(season)/credits"
    guard let url = constructURL(apiUrl: apiUrl) else {
      debugPrint("Rep: Invalid URL")
      return ([], [])
    }
    
    do {
      let response: CreditResponse = try await service.get(url: url, method: .get)
      return (response.cast, response.crew)
    } catch {
      debugPrint("Rep: Error fetching credits: \(error)")
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
