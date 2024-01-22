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
  func getPopular() async throws -> [TV]
  func getTopRated() async throws -> [TV]
  func getAiringToday() async throws -> [TV]
  func getOnTheAir() async throws -> [TV]
  func getTrending() async throws -> [TV]
  func getTVDetail(id: Int) async throws -> DetailTV
  func getTVCredits(id: Int, season: Int) async throws -> (cast: [Cast], crew: [Crew])
  func getEpisodes(id: Int, season: Int) async throws -> SeasonDetail
}

class TVRepository: TVApiProtocol {
  let service: NetworkApiService
  static let shared = TVRepository()
  
  init(service: NetworkApiService = NetworkApiService.shared) {
    self.service = service
  }
  
  /// Get popular tv shows
  /// - Returns: Array of tv shows
  func getPopular() async throws -> [TV] {
    let apiUrl = "\(TVApi.base)\(TVApi.Routes.popularTV)"
    guard let url = constructURL(apiUrl: apiUrl) else {
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
  
  /// Get top rated tv shows
  /// - Returns: Array of tv shows
  func getTopRated() async throws -> [TV] {
    let apiUrl = "\(TVApi.base)\(TVApi.Routes.topRatedTV)"
    guard let url = constructURL(apiUrl: apiUrl) else {
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
  
  /// Get airing today tv shows
  /// - Returns: Array of tv shows
  func getAiringToday() async throws -> [TV] {
    let apiUrl = "\(TVApi.base)\(TVApi.Routes.airingTodayTV)"
    guard let url = constructURL(apiUrl: apiUrl) else {
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
  
  /// Get on the air tv shows
  /// - Returns: Array of tv shows
  func getOnTheAir() async throws -> [TV] {
    let apiUrl = "\(TVApi.base)\(TVApi.Routes.onTheAirTV)"
    guard let url = constructURL(apiUrl: apiUrl) else {
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
  
  /// Get trending tv shows
  /// - Returns: Array of tv shows
  func getTrending() async throws -> [TV] {
    let apiUrl = "\(TVApi.baseT)\(TVApi.Routes.trendingToday)"
    guard let url = constructURL(apiUrl: apiUrl) else {
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
  
  /// Get tv show details
  /// - Parameter id: Tv show id
  /// - Returns: DetailTV object
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
  
  /// Get tv show credits
  /// - Parameters:
  ///   - id: Tv show id
  ///   - season: Tv show season
  /// - Returns: Tuple of cast and crew
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
  
  /// Get season episodes
  /// - Parameters:
  ///   - id: Tv show id
  ///   - season: Season number
  /// - Returns: SeasonDetail object
  func getEpisodes(id: Int, season: Int) async throws -> SeasonDetail {
    let apiURL = "\(TVApi.base)/\(id)/season/\(season)"
    guard let url = constructURL(apiUrl: apiURL) else {
      debugPrint("Rep: Invalid URL")
      throw NetworkError.invalidURL
    }
    
    do {
      return try await service.get(url: url, method: .get)
    } catch {
      debugPrint("Rep: Error fetching episodes: \(error)")
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
}
