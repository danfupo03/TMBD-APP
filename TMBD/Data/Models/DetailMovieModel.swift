//
//  DetailMovieModel.swift
//  TMBD
//
//  Created by Dan FuPo on 08/12/23.
//

import Foundation

struct DetailMovieModel: Codable, Identifiable {
    var budget: Int
    var id: Int
    var production_companies: [ProductionCompanies]
    var status: String
    var title: String
    var revenue: Int
    var runtime: Int
}

struct ProductionCompanies: Codable, Identifiable {
    var id: Int
    var logo_path: String?
    var name: String
  
  var fullLogo: URL {
    return URL(string: "https://image.tmdb.org/t/p/original/\(logo_path ?? "")")!
  }
}
