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
          let voteCount = movie.vote_count
          
          let ratingText = String(format: "%.1f", rating)
          let voteText = String(voteCount)
          
          VStack(alignment: .leading, spacing: 20) {
            
            HStack {
              StarRating(stars).frame(width: 100)
              Text(ratingText)
                .foregroundStyle(.yellow)
              Text("(\(voteText) reviews)")
                .foregroundStyle(.white)
            }
            
            Text(movie.title)
              .font(.title)
              .foregroundColor(.white)
            
            HStack {
              Text(dateFormatter(date: movie.release_date))
                .font(.subheadline)
                .foregroundColor(.white)
              
              Text("·")
                .font(.subheadline)
                .foregroundStyle(.white)
              
              Text(runtimeFormatter(runtime: vm.detailMovie.runtime))
                .font(.subheadline)
                .foregroundStyle(.white)
            }
            
            HStack(spacing: 3) {
              ForEach(genreNames(for: movie.genre_ids), id: \.self) { genreName in
                Text(genreName)
                  .padding(.horizontal, 10)
                  .padding(.vertical, 5)
                  .background(Color.gray.opacity(0.4))
                  .foregroundStyle(.white)
                  .font(.subheadline)
                  .cornerRadius(25.0)
                  .lineLimit(1)
              }
            }
            
            Text(movie.overview)
              .font(.body)
              .foregroundColor(.white)
              .lineLimit(nil)
            
            Spacer()
          }
          .padding()
          
          // View Buttons
          ViewButtons(action: {
            dismiss()
          }, systemName: "xmark")
          .offset(x: -175, y: -770)
          
          ViewButtons(action: {}, systemName: "bookmark")
            .offset(x: 175, y: -770)
          
        }
      }
    }
    .edgesIgnoringSafeArea(.all)
    .onAppear {
      Task {
        try await vm.getMovieDetail(id: movie.id)
      }
    }
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
