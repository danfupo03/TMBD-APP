//
//  TVRepository.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import Foundation

struct TVApi {
  static let base = "https://api.themoviedb.org/3/tv"
  static let baseT = "https://api.themoviedb.org/3/trending/movie"
  
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
      debugPrint("Rep: Error fetching series: \(error)")
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
      debugPrint("Rep: Error fetching series: \(error)")
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
      debugPrint("Rep: Error fetching series: \(error)")
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
