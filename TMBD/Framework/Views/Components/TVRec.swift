//
//  TVRec.swift
//  TMBD
//
//  Created by Dan FuPo on 13/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct TVRec: View {
  var tv: TV
  
  var body: some View {
    VStack(alignment: .leading) {
      
      HStack {
        Spacer()
        Text("Recommendation")
          .font(.title2)
          .fontWeight(.bold)
          .padding(.top, 8)
        Spacer()
      }
      
      // Poster Image
      WebImage(url: tv.fullBackDrop)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(5)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      
      HStack {
        Spacer()
        
        // Movie Title
        Text(tv.name)
          .font(.title3)
          .lineLimit(5)
          .multilineTextAlignment(.leading)
        
        Spacer()
      }
      
      HStack(spacing: 3) {
        Spacer()
        
        ForEach(genreNames(for: tv.genre_ids), id: \.self) { genreName in
          Text(genreName)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.gray)
            .foregroundStyle(.white)
            .font(.subheadline)
            .cornerRadius(25.0)
            .lineLimit(1)
        }
        .padding(.bottom, 8)
        
        Spacer()
      }
    }
    .cornerRadius(10)
    
  }
}

#Preview {
  TVRec(tv: TV(id: 1396,
                  genre_ids: [18, 80],
                  adult: false,
                  backdrop_path: "/9faGSFi5jam6pDWGNd0p8JcJgXQ.jpg",
                  origin_country: ["US"],
                  original_name: "Breaking Bad",
                  overview: "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
                  popularity: 409.991,
                  poster_path: "/3xnWaLQjelJDDF7LT1WBo6f4BRe.jpg",
                  first_air_date: "2008-01-20",
                  name: "Breaking Bad",
                  vote_average: 8.898,
                  vote_count: 12924))
}
