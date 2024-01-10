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
          
          Text("Popular").font(.title).fontWeight(.bold)
          
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
          
          Text("Top Rated").font(.title).fontWeight(.bold)
          
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
          }
          
          Text("Now Playing").font(.title).fontWeight(.bold)
          
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
          }
          
          Text("Upcoming").font(.title).fontWeight(.bold)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.upcomingMovies) { movie in
                MovieCard(movie: movie)
                  .onTapGesture {
                    selectedMovie = movie
                    showingSheet = true
                  }
              }
            }
          }
          
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
        await vm.getUpcoming()
      }
    }
  }
}


#Preview {
  MovieList()
}
