//
//  Recommendation.swift
//  TMBD
//
//  Created by Dan FuPo on 10/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct Recommendation: View {
  var movie: Movie
  
  var body: some View {
    VStack(alignment: .leading) {
      
      HStack {
        Spacer()
        Text("Recommendation of the day")
          .font(.title2)
          .fontWeight(.bold)
          .padding(.top, 8)
        Spacer()
      }
      
      // Poster Image
      WebImage(url: movie.fullBackDrop)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(5)
        .frame(width: .infinity, height: .infinity)
      
      HStack {
        Spacer()
        
        // Movie Title
        Text(movie.title)
          .font(.title3)
          .lineLimit(5)
          .multilineTextAlignment(.leading)
        
        Spacer()
      }
      
      HStack(spacing: 3) {
        Spacer()
        
        ForEach(genreNames(for: movie.genre_ids), id: \.self) { genreName in
          Text(genreName)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.gray)
            .foregroundStyle(.white)
            .font(.subheadline)
            .cornerRadius(25.0)
            .lineLimit(1)
        }
        .padding(.bottom, 8)
        
        Spacer()
      }
    }
    .cornerRadius(10)
    
  }
}

#Preview {
  Recommendation(movie: Movie(id: 968051,
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
                              vote_average: 7,
                              vote_count: 776))
}
