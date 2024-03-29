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
  case invalidURL
}

class NetworkApiService {
  static var shared = NetworkApiService()
  
  let apiKey = "12e629d7051e2adf10c4ba97a9c12fcb"
  
  
  /// Method to get data from API
  /// - Parameters:
  ///   - url: API URL
  ///   - method: The HTTP method
  ///   - parameters: The parameters to be encoded in the request
  /// - Returns: The decoded data
  func get<T: Decodable>(url: URL, method: HTTPMethod, parameters: Parameters? = nil) async throws -> T {
    var headers: HTTPHeaders = [:]
    headers["Authorization"] = "Bearer \(apiKey)"
    
    let taskRequest = AF.request(url, method: method, parameters: parameters, headers: headers).validate()
    let response = await taskRequest.serializingData().response
    
    switch response.result {
    case .success(let data):
      do {
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
      } catch {
        debugPrint("Network: Error decoding JSON: \(error)")
        throw NetworkError.decodingFailed
      }
    case let .failure(error):
      debugPrint(error.localizedDescription)
      throw error
    }
  }
  
}



