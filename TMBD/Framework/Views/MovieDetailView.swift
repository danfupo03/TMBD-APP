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
  @StateObject var vm = MovieViewModel()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ScrollView {
      VStack {
        WebImage(url: movie.fullPoster)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: UIScreen.main.bounds.height / 2 + 130)
        
        // Movie Information Section
        ZStack {
          Color.black
            .frame(height: UIScreen.main.bounds.height / 2)
            .shadow(color: .gray, radius: 10)
          
          let stars = movie.vote_average / 2
          let rating = movie.vote_average
          let ratingText = String(format: "%.1f", rating)
          
          VStack(alignment: .leading, spacing: 20) {
            
            HStack {
              StarRating(stars).frame(width: 100)
              Text(ratingText)
                .foregroundStyle(.yellow)
            }
            
            Text(movie.title)
              .font(.title)
              .foregroundColor(.white)
            
            Text("Release Date: \(movie.release_date)")
              .font(.subheadline)
              .foregroundColor(.white)
            
            Text("Genres: \(genreNames(for: movie.genre_ids).joined(separator: ", "))")
              .foregroundStyle(.white)
              .font(.subheadline)
            
            Text(movie.overview)
              .font(.body)
              .foregroundColor(.white)
              .lineLimit(nil) // Allow multiline text
            
            Spacer()
          }
          .padding()
        }
      }
    }
    .edgesIgnoringSafeArea(.all)
  }
}

#Preview {
  MovieDetailView(movie: Movie(id: 901362,
                               genre_ids: [16, 10751, 10402, 14, 35],
                               adult: false,
                               backdrop_path: "/45zVtZx6Tzx3RKeDziK25K9geFf.jpg",
                               original_language: "en",
                               original_title: "Trolls Band Together",
                               overview: "When Branch's brother, Floyd, is kidnapped for his musical talents by a pair of nefarious pop-star villains, Branch and Poppy embark on a harrowing and emotional journey to reunite the other brothers and rescue Floyd from a fate even worse than pop-culture obscurity.",
                               popularity: 4160.929,
                               poster_path: "/bkpPTZUdq31UGDovmszsg2CchiI.jpg",
                               release_date: "2023-09-06",
                               title: "Trolls Band Together",
                               video: false,
                               vote_average: 7.45,
                               vote_count: 776))
}
