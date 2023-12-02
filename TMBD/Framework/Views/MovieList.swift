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
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text("Popular Movies").font(.largeTitle).foregroundStyle(.white)
        ScrollView(.horizontal) {
          HStack {
            ForEach(vm.popularMovies) { movie in
              NavigationLink(destination: MovieDetailView(movie: movie)){
                MovieCard(movie: movie)
              }.buttonStyle(PlainButtonStyle())
            }
          }
        }
        
        Spacer()
        
        Text("Top Rated Movies").font(.largeTitle).foregroundStyle(.white)
        ScrollView(.horizontal) {
          HStack {
            ForEach(vm.topRatedMovies) { movie in
              NavigationLink(destination: MovieDetailView(movie: movie)){
                MovieCard(movie: movie)
              }.buttonStyle(PlainButtonStyle())
            }
          }
        }
      }
      .padding()
      .background(Color(red: 0.14, green: 0.18, blue: 0.20))
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
