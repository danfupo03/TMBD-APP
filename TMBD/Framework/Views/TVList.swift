//
//  TVList.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import SwiftUI

struct TVList: View {
  @StateObject var vm = TVViewModel()
  @State private var isLoading = false
  @State private var showingSheet = false
  @State private var selectedSerie: TV?
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          
//          //Random recommendation of the day
//          ForEach(vm.trendingMovies.prefix(1)) { movie in
//            Recommendation(movie: movie)
//              .onTapGesture {
//                selectedMovie = movie
//                showingSheet = true
//              } .padding(.bottom, 8)
//          }
          
          //Trending movies
          Text("Trending Today").font(.title).fontWeight(.bold)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.popularTV) { tv in
                TVCard(tv: tv)
                  .onTapGesture {
                    selectedSerie = tv
                    showingSheet = true
                  }
              }
            }
          } .padding(.bottom, 8)
          
//          //Top rated movies
//          Text("People's Favorites").font(.title).fontWeight(.bold)
//          
//          ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//              ForEach(vm.topRatedMovies) { movie in
//                MovieCard(movie: movie)
//                  .onTapGesture {
//                    selectedMovie = movie
//                    showingSheet = true
//                  }
//              }
//            }
//          } .padding(.bottom, 8)
//          
//          //Now playing movies
//          Text("Now in Cinemas").font(.title).fontWeight(.bold)
//          
//          ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//              ForEach(vm.nowPlayingMovies) { movie in
//                MovieCard(movie: movie)
//                  .onTapGesture {
//                    selectedMovie = movie
//                    showingSheet = true
//                  }
//              }
//            }
//          } .padding(.bottom, 8)
//          
//          //Upcoming movies
//          Text("Coming Soon").font(.title).fontWeight(.bold)
//          
//          ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//              ForEach(vm.upcomingMovies.filter { movie in
//                let releaseDate = DateFormatter.dateFormatter.date(from: movie.release_date) ?? Date.distantPast
//                return releaseDate > Date()
//              }) { movie in
//                MovieCard(movie: movie)
//                  .onTapGesture {
//                    selectedMovie = movie
//                    showingSheet = true
//                  }
//              }
//            }
//          } .padding(.bottom, 8)
          
        }
        .padding()
      }
    }
    .sheet(isPresented: $showingSheet) {
      if let selectedSerie = selectedSerie {
        //MovieDetailView(movie: selectedMovie)
      }
    }
    .onAppear {
      Task {
        await vm.getPopular()
      }
    }
  }
}

#Preview {
    TVList()
}
