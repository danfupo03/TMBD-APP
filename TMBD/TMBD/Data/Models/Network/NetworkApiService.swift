//
//  NetworkApiService.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation
import Alamofire

class NetworkApiService {
  static var shared = NetworkApiService()
  
  func getMovies(url: URL) async -> [Movies]? {
    let taskRequest = AF.request(url, method: .get).validate()
    let response = await taskRequest.serializingData().response
    
    switch response.result {
    case .success(let data):
      do {
        return try JSONDecoder().decode([Movies].self, from: data)
      } catch {
        return nil
      }
    case let .failure(error):
      debugPrint(error.localizedDescription)
      return nil
    }
  }
}

