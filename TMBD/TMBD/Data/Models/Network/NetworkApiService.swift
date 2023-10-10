//
//  NetworkApiService.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation
import Alamofire

enum NetworkError: Error {
  case requestFailed
  case decodingFailed
}

class NetworkApiService {
  static var shared = NetworkApiService()
  
  private let apiKey = "12e629d7051e2adf10c4ba97a9c12fcb"
  
  func getMovies(url: URL) async throws -> [Movie] {
    var headers: HTTPHeaders = [:]
    headers["Authorization"] = "Bearer \(apiKey)"
    
    print("Request URL: \(url)")
    print("Headers: \(headers)")
    
    let taskRequest = AF.request(url, method: .get, headers: headers).validate()
    let response = await taskRequest.serializingData().response
    
    switch response.result {
    case .success(let data):
      do {
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        return response.results
      } catch {
        debugPrint("Error decoding JSON: \(error)")
        throw NetworkError.decodingFailed
      }
    case let .failure(error):
      debugPrint(error.localizedDescription)
      throw error
    }
  }
}



