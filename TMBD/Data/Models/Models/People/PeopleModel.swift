//
//  PeopleModel.swift
//  TMBD
//
//  Created by Dan FuPo on 17/01/24.
//

import Foundation

struct People: Codable, Hashable, Identifiable {
  var id: Int
  var gender: Int
  var known_for_department: String
  var name: String
  var popularity: Double
  var profile_path: String?
  var known_for: [KnownFor]
  
  var profile: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(profile_path ?? "")")!
  }
}

struct KnownFor: Codable, Identifiable, Hashable {
  var id: Int
  var backdrop_path: String?
  var title: String?
  var overview: String
  var poster_path: String?
  var media_type: String
  var genre_ids: [Int]
  var release_date: String?
  var popularity: Double
  var vote_average: Double
  
  var poster: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(poster_path ?? "")")!
  }
  
  var backDrop: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(backdrop_path ?? "")")!
  }
}

struct PeopleResponse: Codable {
  var results: [People]
}
