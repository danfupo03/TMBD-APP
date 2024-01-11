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
        
        ZStack(alignment: .top) {
          
          // Poster
          WebImage(url: movie.fullPoster)
            .resizable()
            .aspectRatio(contentMode: .fit)
          
          // View Buttons
          HStack {
            ViewButtons(action: {
              dismiss()
            }, systemName: "xmark")
            
            Spacer()
            
            ViewButtons(action: {}, systemName: "bookmark")
          }
          .padding()
        }
        
        // Movie Information Section
        ZStack {
          Color.black
            .shadow(color: .gray, radius: 10)
          
          let stars = movie.vote_average / 2
          let rating = movie.vote_average
          let voteCount = movie.vote_count
          
          let ratingText = String(format: "%.1f", rating)
          let voteText = String(voteCount)
          
          VStack(alignment: .leading, spacing: 10) {
            
            HStack {
              StarRating(stars).frame(width: 100)
              Text(ratingText)
                .foregroundStyle(.yellow)
              Text("(\(voteText) reviews)")
                .foregroundStyle(.white)
            }
            .padding(.bottom, 10)
            
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
            .padding(.bottom, 15)
            
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
            .padding(.bottom, 15)
            
            Text("Overview")
              .foregroundStyle(.white)
              .font(.title3)
            
            Text(movie.overview)
              .font(.body)
              .foregroundColor(.white)
              .lineLimit(nil)
              .padding(.bottom, 15)
            
            HStack {
              Text("Stars")
                .foregroundStyle(.white)
                .font(.title3)
              
              Image(systemName: "star")
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
              LazyHStack (spacing: 20) {
                ForEach(vm.movieCredits.cast.prefix(5)) { cast in
                  CastCard(cast: cast)
                    .frame(maxWidth: .infinity, maxHeight: 230)
                }
              }
            }
            
            .padding(.bottom, 15)
            
            HStack {
              Text("Screenplay")
                .foregroundStyle(.white)
                .font(.title3)
              
              Image(systemName: "movieclapper")
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
              LazyHStack (spacing: 20) {
                ForEach(vm.movieCredits.crew.filter { $0.job == "Director"}) { crew in
                  CrewCard(crew: crew)
                    .frame(maxWidth: .infinity, maxHeight: 230)
                }
              }
            }
            .padding(.bottom, 15)
            
            HStack {
              Text("Production companies")
                .foregroundStyle(.white)
                .font(.title3)
              
              Image(systemName: "house.fill")
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            
            HStack {
              Text(vm.detailMovie.production_companies.map { $0.name }.joined(separator: ", "))
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            .padding(.bottom, 15)
          }
          .padding()
        }
      }
    }
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
    .onAppear {
      Task {
        try await vm.getMovieDetail(id: movie.id)
        await vm.getMovieCredits(id: movie.id)
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
