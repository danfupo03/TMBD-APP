//
//  MovieModel.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import Foundation

struct Movie: Codable, Hashable, Identifiable {
  var id: Int
  var adult: Bool
  var backdrop_path: String
  var original_language: String
  var original_title: String
  var overview: String
  var popularity: Double
  var poster_path: String
  var release_date: String
  var title: String
  var video: Bool
  var vote_average: Double
  var vote_count: Int 
  
  var fullBackDrop: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(backdrop_path)")!
  }
  
  var fullPoster: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(poster_path)")!
  }
}

struct MovieResponse: Codable {
  var results: [Movie]
}
