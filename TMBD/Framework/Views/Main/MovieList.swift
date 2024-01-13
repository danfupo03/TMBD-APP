//
//  MovieList.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieList: View {
  @StateObject var vm = MovieViewModel()
  @State private var isLoading = false
  @State private var showingSheet = false
  @State private var selectedMovie: Movie?
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          
          //Random recommendation of the day
          ForEach(vm.trendingMovies.prefix(1)) { movie in
            MovieRec(movie: movie)
              .onTapGesture {
                selectedMovie = movie
                showingSheet = true
              } .padding(.bottom, 8)
          }
          
          //Trending movies
          Text("Trending Today").font(.title).fontWeight(.bold)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.popularMovies) { movie in
                MovieCard(movie: movie)
                  .onTapGesture {
                    selectedMovie = movie
                    showingSheet = true
                  }
              }
            }
          } .padding(.bottom, 8)
          
          //Top rated movies
          Text("People's Favorites").font(.title).fontWeight(.bold)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.topRatedMovies) { movie in
                MovieCard(movie: movie)
                  .onTapGesture {
                    selectedMovie = movie
                    showingSheet = true
                  }
              }
            }
          } .padding(.bottom, 8)
          
          //Now playing movies
          Text("Now in Cinemas").font(.title).fontWeight(.bold)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.nowPlayingMovies) { movie in
                MovieCard(movie: movie)
                  .onTapGesture {
                    selectedMovie = movie
                    showingSheet = true
                  }
              }
            }
          } .padding(.bottom, 8)
          
          //Upcoming movies
          Text("Coming Soon").font(.title).fontWeight(.bold)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.upcomingMovies.filter { movie in
                let releaseDate = DateFormatter.dateFormatter.date(from: movie.release_date) ?? Date.distantPast
                return releaseDate > Date()
              }) { movie in
                MovieCard(movie: movie)
                  .onTapGesture {
                    selectedMovie = movie
                    showingSheet = true
                  }
              }
            }
          } .padding(.bottom, 8)
          
        }
        .padding()
      }
    }
    .sheet(isPresented: $showingSheet) {
      if let selectedMovie = selectedMovie {
        MovieDetailView(movie: selectedMovie)
      }
    }
    .onAppear {
      Task {
        await vm.getPopular()
        await vm.getTopRated()
        await vm.getNowPlaying()
        await vm.getUpcoming(pages: 5)
        await vm.getTrending(pages: 2)
      }
    }
  }
}

extension DateFormatter {
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
}

#Preview {
  MovieList()
}
