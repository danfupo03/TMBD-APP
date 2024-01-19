//
//  TVModel.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import Foundation

struct TV: Codable, Hashable, Identifiable {
  var id: Int
  var genre_ids: [Int]
  var adult: Bool
  var backdrop_path: String?
  var origin_country: [String]
  var original_name: String
  var overview: String
  var popularity: Double
  var poster_path: String?
  var first_air_date: String
  var name: String
  var vote_average: Double
  var vote_count: Int
  
  var fullBackDrop: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(backdrop_path ?? "")")!
  }
  
  var fullPoster: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(poster_path ?? "")")!
  }
}

struct TVResponse: Codable {
  var results: [TV]
}
