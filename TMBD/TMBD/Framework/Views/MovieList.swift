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
          MovieCard(movie: movie)
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
              .background(Color.blue)
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

struct MovieCard: View {
  @Environment(\.colorScheme) var colorScheme
  var movie: Movie
  let cardAndImageWidth: CGFloat = 365
  let cardHeight: CGFloat = 256
  let imageHeight: CGFloat = 206
  let cornerRadius: CGFloat = 5
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius)
        .strokeBorder(colorScheme == .dark ? SwiftUI.Color.white : SwiftUI.Color.gray, lineWidth: 1)
        .frame(width: cardAndImageWidth, height: cardHeight)
        .background(SwiftUI.Color.white)
      
      VStack(alignment: .leading, spacing: 10){
        WebImage(url: movie.fullBackDrop)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: cardAndImageWidth)
          .clipped()
        VStack(alignment: .leading, spacing: 2) {
          Text(movie.title)
            .font(.custom("Avenir", size: 14))
            .fontWeight(.bold)
          Text(movie.original_language)
            .font(.custom("Avenir", size: 12))
            .foregroundColor(SwiftUI.Color.gray)
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 11)
      }
      .frame(width: cardAndImageWidth, height: cardHeight)
      .cornerRadius(cornerRadius)
    }
  }
}


#Preview {
  MovieList()
}
