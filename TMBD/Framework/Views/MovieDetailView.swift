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
    ScrollView {
      VStack {
        Text(movie.original_title).font(.largeTitle)
        WebImage(url: movie.fullPoster)
          .resizable()
          .frame(width: 320, height: 500)
          .cornerRadius(10)
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.gray)
          .frame(width: 320, height: 150)
          .padding()
          .overlay(
            VStack(alignment: .center, spacing: 10) {
              Text("Overview:")
                .font(.headline)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top)
              Text(movie.overview)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(5)
                .font(.body)
                .padding([.leading, .trailing], 30)
                .padding(.bottom)
            }
          )
        Spacer()
      }
    }
  }
}

#Preview {
  MovieDetailView(movie: Movie(id: 968051,
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
