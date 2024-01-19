//
//  Seasons.swift
//  TMBD
//
//  Created by Dan FuPo on 14/01/24.
//

import Foundation

struct SeasonDetail: Codable, Identifiable {
  var id: Int
  var air_date: String?
  var episodes: [Episode]
  var name: String
  var overview: String
  var poster_path: String?
  var season_number: Int
  var vote_average: Double
  
  var poster: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(poster_path ?? "")")!
  }
}

struct Episode: Codable, Identifiable {
  var id: Int
  var air_date: String?
  var episode_number: Int
  var episode_type: String
  var name: String
  var overview: String
  var runtime: Int?
  var vote_average: Double
  var still_path: String?
  
  var still: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(still_path ?? "")")!
  }
}
