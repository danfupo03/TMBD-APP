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
          
          //Top rated movies
          Text("People's Favorites").font(.title).fontWeight(.bold)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.topRatedTV) { tv in
                TVCard(tv: tv)
                  .onTapGesture {
                    selectedSerie = tv
                    showingSheet = true
                  }
              }
            }
          } .padding(.bottom, 8)
          
          //Now playing movies
          Text("On the air").font(.title).fontWeight(.bold)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.onAirTV) { tv in
                TVCard(tv: tv)
                  .onTapGesture {
                    selectedSerie = tv
                    showingSheet = true
                  }
              }
            }
          } .padding(.bottom, 8)
          
          //Upcoming movies
          Text("Airing today").font(.title).fontWeight(.bold)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(vm.airingTV) { tv in
                TVCard(tv: tv)
                  .onTapGesture {
                    selectedSerie = tv
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
      if let selectedSerie = selectedSerie {
        //MovieDetailView(movie: selectedMovie)
      }
    }
    .onAppear {
      Task {
        await vm.getPopular()
        await vm.getTopRated()
        await vm.getOnTheAir()
        await vm.getAiringToday()
        await vm.getTrending(pages: 3)
      }
    }
  }
}

#Preview {
  TVList()
}
