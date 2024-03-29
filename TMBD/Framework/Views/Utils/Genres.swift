//
//  Genres.swift
//  TMBD
//
//  Created by Dan FuPo on 08/12/23.
//

import Foundation

/// <#Description#>
/// - Parameter genreIds: <#genreIds description#>
/// - Returns: <#description#>
func genreNames(for genreIds: [Int]) -> [String] {
  let genreMapping: [Int: String] = [
    12: "Adventure",
    14: "Fantasy",
    16: "Animation",
    18: "Drama",
    27: "Horror",
    28: "Action",
    35: "Comedy",
    36: "History",
    37: "Western",
    53: "Thriller",
    80: "Crime",
    99: "Documentary",
    878: "Science Fiction",
    9648: "Mystery",
    10402: "Music",
    10749: "Romance",
    10751: "Family",
    10752: "War",
    10759: "Action & Adventure",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10765: "Sci-Fi & Fantasy",
    10766: "Soap",
    10767: "Talk",
    10768: "War & Politics",
    10770: "TV Movie"
    
  ]
  
  let genreNames = genreIds.compactMap { genreMapping[$0] }
  
  return genreNames
}
