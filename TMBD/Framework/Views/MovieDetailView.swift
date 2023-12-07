//
//  MovieDetailView.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
  var movie: Movie
  
  var body: some View {
    ZStack() {
      WebImage(url: movie.fullPoster)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
        .opacity(0.9)
        .offset(x: -25, y: 0)
      
      Rectangle()
        .foregroundColor(Color.black)
        .opacity(0.8)
        .ignoresSafeArea()
      
      VStack {
        HStack {
          WebImage(url: movie.fullPoster)
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .cornerRadius(10)
            .padding(.trailing, 30)
          
          Text(movie.title)
            .font(Font.custom("Inter", size: 25).weight(.bold))
            .foregroundColor(.white)
        }
        .frame(width: 350)
        
        VStack (alignment: .leading) {
          Text("Overview").font(.title)
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding([.top, .bottom])
          
          Text(movie.overview)
            .foregroundStyle(.white)
          
        } .padding([.trailing, .leading], 70)
      }
      
    }
  }
}

#Preview {
  MovieDetailView(movie: Movie(id: 901362,
                               genre_ids: [16, 10751, 10402, 14, 35],
                               adult: false,
                               backdrop_path: "/mRGmNnh6pBAGGp6fMBMwI8iTBUO.jpg",
                               original_language: "en",
                               original_title: "The Nun II",
                               overview: "When Branch's brother, Floyd, is kidnapped for his musical talents by a pair of nefarious pop-star villains, Branch and Poppy embark on a harrowing and emotional journey to reunite the other brothers and rescue Floyd from a fate even worse than pop-culture obscurity.",
                               popularity: 4160.929,
                               poster_path: "/bkpPTZUdq31UGDovmszsg2CchiI.jpg",
                               release_date: "2023-09-06",
                               title: "Trolls Band Together",
                               video: false,
                               vote_average: 7,
                               vote_count: 776))
}
