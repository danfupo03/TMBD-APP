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
  let cardAndImageWidth: CGFloat = 365
  let cardHeight: CGFloat = 256
  let imageHeight: CGFloat = 206
  let cornerRadius: CGFloat = 5
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius)
        .strokeBorder(colorScheme == .dark ? SwiftUI.Color.white : SwiftUI.Color.gray, lineWidth: 1)
        .frame(width: cardAndImageWidth, height: cardHeight)
        .background(SwiftUI.Color.white)
      
      VStack(alignment: .leading, spacing: 10){
        WebImage(url: movie.fullBackDrop)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: cardAndImageWidth)
          .clipped()
        VStack(alignment: .leading, spacing: 2) {
          Text(movie.title)
            .font(.custom("Avenir", size: 14))
            .fontWeight(.bold)
          Text(movie.release_date)
            .font(.custom("Avenir", size: 12))
            .foregroundColor(SwiftUI.Color.gray)
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 11)
      }
      .frame(width: cardAndImageWidth, height: cardHeight)
      .cornerRadius(cornerRadius)
    }
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
