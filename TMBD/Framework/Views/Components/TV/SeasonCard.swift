//
//  SeasonCard.swift
//  TMBD
//
//  Created by Dan FuPo on 14/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SeasonCard: View {
  var season: Seasons
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 40) {
        // Season poster
        WebImage(url: season.poster)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(5)
          .frame(width: 150, height: 225)
        
        VStack(alignment: .leading) {
          
          // Seasons air date
          Text("Season Air Date")
          Text(season.air_date ?? "")
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.bottom, 10)
          
          HStack {
            let count = season.episode_count
            let countText = String(count)
            
            Text("\(countText) episodes")
              .font(.subheadline)
              .foregroundStyle(.blue)
          }
          .padding(.bottom, 10)
          
          // Rating
          HStack {
            Text("Rating:")
              .font(.subheadline)
              .foregroundColor(.gray)
            
            let rating = season.vote_average
            
            if rating == 0.0 {
              Text("No rating")
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
      }
      .padding(.bottom)
      
      // Season overview
      if season.overview != "" {
        Text("Overview:")
        
        Text(season.overview)
          .font(.subheadline)
          .padding([.bottom, .trailing], 10)
      }
    }
    .padding()
  }
}

#Preview {
  SeasonCard(season: Seasons(id: 3572,
                             air_date: "2008-01-20",
                             episode_count: 7,
                             name: "Season 1",
                             overview: "High school chemistry teacher Walter White's life is suddenly transformed by a dire medical diagnosis. Street-savvy former student Jesse Pinkman \"teaches\" Walter a new trade.",
                             poster_path: "/1BP4xYv9ZG4ZVHkL7ocOziBbSYH.jpg",
                             season_number: 1,
                             vote_average: 8.2))
}
