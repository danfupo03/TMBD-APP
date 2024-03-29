//
//  MovieCard.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCard: View {
  var movie: Movie
  
  var body: some View {
    VStack(alignment: .leading) {
      // Poster Image
      WebImage(url: movie.fullPoster)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(5)
        .frame(width: 150, height: 225)
      
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
        
        if rating == 0.0 {
          Text("No rating yet")
            .font(.subheadline)
            .foregroundColor(.orange)
          
        } else {
          let ratingText = String(format: "%.1f/10", rating)
          
          Text(ratingText)
            .font(.subheadline)
            .foregroundColor(rating >= 8.0 ? .green : (rating >= 5.0 ? .yellow : .red))
        }
      }
      
    }
    .frame(minWidth: 0, maxWidth: 150, minHeight: 0, maxHeight: .infinity)
    .padding()
    .cornerRadius(15)
  }
}

#Preview {
  MovieCard(movie: Movie(id: 968051,
                         genre_ids: [27, 93],
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
                         vote_average: 0.0,
                         vote_count: 776))
}
