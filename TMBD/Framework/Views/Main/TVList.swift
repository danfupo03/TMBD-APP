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
          
          //Trending recommendation of the day
          ForEach(vm.trendingTV.prefix(1)) { tv in
            TVRec(tv: tv)
              .onTapGesture {
                selectedSerie = tv
                showingSheet = true
              } .padding(.bottom, 8)
          }
          
          //Trending tv shows
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
          
          //Top rated tv shows
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
          
          //On the air shows
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
          
          //Airing shows
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
        TVDetailView(tv: selectedSerie)
      }
    }
    .onAppear {
      Task {
        await vm.getPopular()
        await vm.getTopRated()
        await vm.getOnTheAir()
        await vm.getAiringToday()
        await vm.getTrending()
      }
    }
  }
}

#Preview {
  TVList()
}
