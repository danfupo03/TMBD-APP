//
//  TVCard.swift
//  TMBD
//
//  Created by Dan FuPo on 12/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct TVCard: View {
  var tv: TV
  
  var body: some View {
    VStack(alignment: .leading) {
      // Poster Image
      if tv.poster_path == nil {
        WebImage(url: URL(string: "https://w0.peakpx.com/wallpaper/414/855/HD-wallpaper-television-is-back-block-blurred-vision-communication-evanthia-palatou-life-lines-movie-signal-television-tv.jpg"))
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(5)
          .frame(width: 150, height: 225)
      } else {
        WebImage(url: tv.fullPoster)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(5)
          .frame(width: 150, height: 225)
      }
      
      // Movie Title
      Text(tv.name)
        .font(.headline)
        .lineLimit(5)
        .multilineTextAlignment(.leading)
      
      // Release Date
      Text(tv.first_air_date)
        .font(.subheadline)
        .foregroundColor(.gray)
      
      // Rating
      HStack {
        Text("Rating:")
          .font(.subheadline)
          .foregroundColor(.gray)
        
        let rating = tv.vote_average
        
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
    .frame(minWidth: 0, maxWidth: 150, minHeight: 0, maxHeight: .infinity)
    .padding()
    .cornerRadius(15)
  }
}

#Preview {
  TVCard(tv: TV(id: 15260,
                genre_ids: [16, 35, 10765],
                adult: false,
                origin_country: ["US"],
                original_name: "Adventure Time",
                overview: "Hook up with Finn and Jake as they travel the Land of Ooo searching for adventure. But remember, adventure isn’t always easy. Sometimes you’ve got to battle fire gnomes that torture old ladies, save a smelly hot dog princess from the Ice King, and thaw out a bunch of frozen businessmen. What the cabbage?!",
                popularity: 2441.479,
                poster_path: nil,
                first_air_date: "2010-04-05",
                name: "Adventure Time",
                vote_average: 0.0,
                vote_count: 2577))
}
