//
//  TVEpisodes.swift
//  TMBD
//
//  Created by Dan FuPo on 13/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct TVEpisodes: View {
  var tv: TV
  @StateObject var vm = TVViewModel()
  
  var body: some View {
    ScrollView {
      ZStack {
        Color.black
        
        VStack(alignment: .leading) {
          Text("Seasons").font(.largeTitle)
          ForEach(vm.detailTV.seasons) { season in
            DisclosureGroup(season.name) {
              SeasonCard(season: season)
            }
          }
        }
      }
    }
    .padding()
    .navigationTitle("Episodes").foregroundStyle(.white)
    .background(Color.black)
    .onAppear {
      Task {
        try await vm.getTVDetail(id: tv.id)
      }
    }
    
  }
}

#Preview {
  TVEpisodes(tv: TV(id: 1396,
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
