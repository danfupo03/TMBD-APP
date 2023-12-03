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
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          Text("Popular Movies").font(.custom("AmericanTypewriter", fixedSize: 34)
              .weight(.heavy))
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.popularMovies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)){
                  MovieCard(movie: movie)
                }.buttonStyle(PlainButtonStyle())
              }
            }
          } .padding(.bottom, 8)
          
          Spacer()
          
          Text("Top Rated Movies").font(.custom("AmericanTypewriter", fixedSize: 34)
              .weight(.heavy))
          ScrollView(.horizontal, showsIndicators: false) {
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
