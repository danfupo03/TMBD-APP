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
          Text("Popular Movies").font(.custom("AmericanTypewriter", fixedSize: 34)
            .weight(.heavy))
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
          
          Text("Top Rated Movies").font(.custom("AmericanTypewriter", fixedSize: 34)
            .weight(.heavy))
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
      }
    }
  }
}


#Preview {
  MovieList()
}
