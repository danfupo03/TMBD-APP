//
//  DetailTVModel.swift
//  TMBD
//
//  Created by Dan FuPo on 13/01/24.
//

import Foundation

struct DetailTV: Codable, Identifiable {
  var id: Int
  //var created_by: [CreatedBy]
  var episode_run_time: [Int]
  var homepage: String
  var in_production: Bool
  var last_air_date : String
  //var last_episode_to_air: LastEpisodeToAir
  //var next_episode_to_air: NextEpisodeToAir
  //var networks: [Networks]
  var number_of_episodes: Int
  var number_of_seasons: Int
  var origin_country: [String]
  var original_language: String
  var production_companies: [ProductionCompanies]
  //var seasons: [Seasons]
  var status: String
  var tagline: String
  var type: String
}

struct CreatedBy: Codable, Identifiable {
  var id: Int
  var name: String
  var gender: Int
  var profile_path: String?
  
  var fullProfile: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(profile_path ?? "")")!
  }
}

struct LastEpisodeToAir: Codable, Identifiable {
  var id: Int
  var name: String
  var overview: String
  var vote_average: Int
  var vote_count: Int
  var episode_number: Int
  var episode_type: String
  var runtime: Int
  var season_number: Int
  var still_path: String?
  
  var stillPath: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(still_path ?? "")")!
  }
}

struct NextEpisodeToAir: Codable, Identifiable {
  var id: Int
  var name: String
  var overview: String
  var vote_average: Int
  var vote_count: Int
  var air_date: String
  var episode_number: Int
  var episode_type: String
  var runtime: Int
  var season_number: Int
  var still_path: String?
  
  var stillPath2: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(still_path ?? "")")!
  }
}

struct Networks: Codable, Identifiable {
  var id: Int
  var logo_path: String?
  var name: String
  var origin_country: String
  
  var fullLogo: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(logo_path ?? "")")!
  }
}

struct Seasons: Codable, Identifiable {
  var id: Int
  var air_date: String
  var episode_count: Int
  var name: String
  var overview: String
  var poster_path: String
  var season_number: Int
  var vote_average: Int
}
