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
    NavigationStack {
      ScrollView {
        Text("Movie List").font(.largeTitle)
        ForEach(vm.movies) { movie in
          NavigationLink(destination: MovieDetailView(movie: movie)){
            MovieCard(movie: movie)
          }.buttonStyle(PlainButtonStyle())
        }
        if isLoading {
          ProgressView()
        } else {
          Button(action: {
            isLoading = true
            Task {
              await vm.getMovies()
              isLoading = false
            }
          }) {
            Text("Load More")
              .padding()
              .background(Color.gray)
              .foregroundColor(.white)
              .cornerRadius(10)
          }
          .padding()
        }
      }
    }
    .onAppear {
      Task {
        await vm.getMovies()
      }
    }
  }
}

#Preview {
  MovieList()
}
