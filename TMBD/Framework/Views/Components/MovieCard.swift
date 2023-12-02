//
//  MovieCard.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCard: View {
  @Environment(\.colorScheme) var colorScheme
  var movie: Movie
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      // Poster Image
      WebImage(url: movie.fullPoster)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(10)
        .clipped()
        .padding(.bottom, 8)
      
      // Movie Title
      Text(movie.title)
        .font(.headline)
        .lineLimit(5)
        .multilineTextAlignment(.leading)
      
      // Release Date
      Text(movie.release_date)
        .font(.subheadline)
        .foregroundColor(.gray)
      
      // Rating
      HStack {
        Text("Rating:")
          .font(.subheadline)
          .foregroundColor(.gray)
        
        let rating = movie.vote_average
        let ratingText = String(format: "%.1f/10", rating)
        
        Text(ratingText)
          .font(.subheadline)
          .foregroundColor(rating >= 8.0 ? .green : (rating >= 5.0 ? .yellow : .red))
      }
      
    }
    .padding()
    .background(Color.white)
    .cornerRadius(15)
    .shadow(radius: 5)
  }
}

#Preview {
  MovieCard(movie: Movie(id: 968051,
                         adult: false,
                         backdrop_path: "/mRGmNnh6pBAGGp6fMBMwI8iTBUO.jpg",
                         original_language: "en",
                         original_title: "The Nun II",
                         overview: "In 1956 France, a priest is violently murdered, and Sister Irene begins to investigate. She once again comes face-to-face with a powerful evil.",
                         popularity: 4160.929,
                         poster_path: "/5gzzkR7y3hnY8AD1wXjCnVlHba5.jpg",
                         release_date: "2023-09-06",
                         title: "The Nun II",
                         video: false,
                         vote_average: 7,
                         vote_count: 776))
}