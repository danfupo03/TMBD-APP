//
//  MovieList.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import SwiftUI

struct MovieList: View {
  @StateObject var vm = MovieViewModel()
  
    var body: some View {
      NavigationStack {
        ScrollView {
          Text("Movie List")
          ForEach(vm.movies) { movie in
            Text(movie.title)
          }
        }
      } .onAppear {
        Task {
          await vm.getMovies()
        }
      }
    }
}

#Preview {
    MovieList()
}
