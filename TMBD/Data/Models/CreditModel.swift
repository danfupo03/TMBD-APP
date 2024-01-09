//
//  CreditModel.swift
//  TMBD
//
//  Created by Dan FuPo on 08/01/24.
//

import Foundation

struct Cast: Codable, Identifiable {
  var adult: Bool
  var gender: Int
  var id: Int
  var known_for_department: String
  var name: String
  var original_name: String
  var popularity: Double
  var profile_path: String?
  var character: String
  
  var fullProfilePath: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(profile_path ?? "")")!
  }
}

struct Crew: Codable, Identifiable {
  var adult: Bool
  var gender: Int
  var id: Int
  var known_for_department: String
  var name: String
  var original_name: String
  var popularity: Double
  var profile_path: String?
  var job: String
  
  var fullProfilePath: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(profile_path ?? "")")!
  }
}

struct CreditResponse: Codable {
  var cast: [Cast]
  var crew: [Crew]
}
