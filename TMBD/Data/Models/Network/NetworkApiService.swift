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
  
  let apiKey = "12e629d7051e2adf10c4ba97a9c12fcb"
  
  /// Function to make a generic API request
  /// - Parameters:
  ///   - url: The URL for the request
  ///   - method: The HTTP method for the request
  ///   - parameters: The parameters for the request
  /// - Returns: The response data
  func get<T: Decodable>(url: URL, method: HTTPMethod, parameters: Parameters? = nil) async throws -> T {
    var headers: HTTPHeaders = [:]
    headers["Authorization"] = "Bearer \(apiKey)"
    
    let taskRequest = AF.request(url, method: method, parameters: parameters, headers: headers).validate()
    let response = await taskRequest.serializingData().response
    
    switch response.result {
    case .success(let data):
      do {
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        // Assuming `MovieResponse` has a property `results` which is an array
        guard let decodedData = response.results as? T else {
          debugPrint("Error: Unexpected structure in JSON response")
          throw NetworkError.decodingFailed
        }
        
        return decodedData
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



