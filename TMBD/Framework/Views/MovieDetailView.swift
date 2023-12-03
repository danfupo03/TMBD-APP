//
//  MovieDetailView.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
  var movie: Movie
  
  var body: some View {
    ZStack() {
      WebImage(url: movie.fullPoster)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
        .opacity(0.9)
        .offset(x: -25, y: 0)
      
      Rectangle()
        .foregroundColor(Color.black)
        .opacity(0.8)
        .frame(width: 430, height: 410)
        .cornerRadius(10)
        .offset(x: 0, y: 233)
      
      VStack(alignment: .leading, spacing: 10) {
        HStack {
          WebImage(url: movie.fullPoster)
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .cornerRadius(10)
            .padding(.trailing, 30)
          
          Text(movie.title)
            .font(Font.custom("Inter", size: 25).weight(.bold))
            .foregroundColor(.white)
        }
        
      } .offset(x: 0, y: 60)
      
    }
    //.frame(width: 430, height: 932)
  }
}

#Preview {
  MovieDetailView(movie: Movie(id: 968051,
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
