//
//  EpisodesCard.swift
//  TMBD
//
//  Created by Dan FuPo on 14/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct EpisodesCard: View {
  var episode: Episode
  
  let cardAndImageWidth: CGFloat = 365
  let cardHeight: CGFloat = 256
  let imageHeight: CGFloat = 206
  let cornerRadius: CGFloat = 5
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius)
        .strokeBorder(SwiftUI.Color.gray)
        .frame(width: cardAndImageWidth, height: cardHeight)
        .background(SwiftUI.Color.white)
      
      VStack(alignment: .leading, spacing: 10){
        WebImage(url: episode.still)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: cardAndImageWidth)
          .clipped()
        VStack(alignment: .leading, spacing: 2) {
          Text(episode.name)
            .font(.custom("Avenir", size: 14))
            .fontWeight(.bold)
          Text(episode.overview)
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
  EpisodesCard(episode: Episode(id: 1953812,
                                air_date: "2021-11-06",
                                episode_number: 1,
                                episode_type: "standard",
                                name: "Welcome to the Playground",
                                overview: "Orphaned sisters Vi and Powder bring trouble to Zaun's underground streets in the wake of a heist in posh Piltover.",
                                runtime: 44,
                                vote_average: 8.314,
                                still_path: "/uPdGDBBsQg54RpWsCzqmHmd5gFm.jpg"))
}
