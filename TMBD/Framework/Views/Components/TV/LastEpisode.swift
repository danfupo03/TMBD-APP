//
//  EpisodeCard.swift
//  TMBD
//
//  Created by Dan FuPo on 16/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LastEpisode: View {
  var last: LastEpisodeToAir
  let cardAndImageWidth: CGFloat = 365
  let cardHeight: CGFloat = .infinity
  let imageHeight: CGFloat = 206
  let cornerRadius: CGFloat = 5
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius)
        .strokeBorder(Color.black, lineWidth: 1)
        .frame(maxWidth: cardAndImageWidth, maxHeight: cardHeight)
      
      let episode_number = String(last.episode_number)
      let season_number = String(last.season_number)
      
      VStack(alignment: .leading, spacing: 10){
        
        if last.still_path == nil {
          WebImage(url: URL(string: "https://media.gq.com/photos/5df5a3794e7a380009b83bbd/16:9/w_2560%2Cc_limit/BestShows.jpg"))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: cardAndImageWidth)
            .clipped()
        } else {
          WebImage(url: last.stillPath)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: cardAndImageWidth)
            .clipped()
        }
        
        VStack(alignment: .leading, spacing: 4) {
          Text("\(last.name) · S\(season_number) E\(episode_number) · \(runtimeFormatter(runtime: last.runtime ?? 0))")
            .font(.subheadline)
            .fontWeight(.bold)
          
          Text(last.air_date)
            .font(.subheadline)
            .foregroundStyle(.blue)
          
          Text(last.overview)
            .font(.subheadline)
            .foregroundStyle(.gray)
          
          HStack {
            Text("Rating:")
              .font(.subheadline)
              .foregroundColor(.gray)
            
            let rating = last.vote_average
            
            if rating == 0.0 {
              Text("No rating yet")
                .font(.subheadline)
                .foregroundColor(.orange)
              
            } else {
              let ratingText = String(format: "%.1f/10", rating)
              
              Text(ratingText)
                .font(.subheadline)
                .foregroundColor(rating >= 8.0 ? .green : (rating >= 5.0 ? .yellow : .red))
            }
          }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 11)
      }
      .frame(maxWidth: cardAndImageWidth, maxHeight: cardHeight)
      .cornerRadius(cornerRadius)
    }
  }
}

#Preview {
  LastEpisode(last: LastEpisodeToAir(id: 4317023,
                                     name: "Under Siege",
                                     overview: "After one of their own is shot, the team suffers a series of close calls and realizes their division may be a target for a group of masked assailants.",
                                     vote_average: 6.5,
                                     vote_count: 6,
                                     air_date: "2023-05-02",
                                     episode_number: 22,
                                     episode_type: "finale",
                                     runtime: 43,
                                     season_number: 5,
                                     still_path: "/d26OwS9UCzYnI8m79d9NEvBFe4X.jpg"))
}
