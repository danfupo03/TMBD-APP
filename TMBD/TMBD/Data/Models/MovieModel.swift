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
  var popularity: Float
  var poster_path: String
  var release_date: String
  var title: String
  var video: Bool
  var vote_average: Int
  var vote_count: Int 
}

struct MovieResponse: Codable {
  var result: [Movie]
}
