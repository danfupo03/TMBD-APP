//
//  TVDetailView.swift
//  TMBD
//
//  Created by Dan FuPo on 13/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct TVDetailView: View {
  var tv: TV
  
  @StateObject var vm = TVViewModel()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ScrollView {
      VStack {
        
        ZStack(alignment: .top) {
          
          // Poster
          WebImage(url: tv.fullPoster)
            .resizable()
            .aspectRatio(contentMode: .fit)
          
          // View Buttons
          HStack {
            ViewButtons(action: {
              dismiss()
            }, systemName: "xmark")
            
            Spacer()
            
            ViewButtons(action: {}, systemName: "bookmark")
          }
          .padding()
        }
        
        // Movie Information Section
        ZStack {
          Color.black
            .shadow(color: .gray, radius: 10)
          
          let stars = tv.vote_average / 2
          let rating = tv.vote_average
          let voteCount = tv.vote_count
          
          let ratingText = String(format: "%.1f", rating)
          let voteText = String(voteCount)
          
          VStack(alignment: .leading, spacing: 10) {
            
            HStack {
              StarRating(stars).frame(width: 100)
              Text(ratingText)
                .foregroundStyle(.yellow)
              Text("(\(voteText) reviews)")
                .foregroundStyle(.white)
            }
            .padding(.bottom, 10)
            
            Text(tv.name)
              .font(.title)
              .foregroundColor(.white)
            
            HStack {
              Text(dateFormatter(date: tv.first_air_date))
                .font(.subheadline)
                .foregroundColor(.white)
              
              Text("·")
                .font(.subheadline)
                .foregroundStyle(.white)
              
              Text(vm.detailTV.homepage)
                .font(.subheadline)
                .foregroundStyle(.white)
              
            }
            .padding(.bottom, 15)
            
            HStack(spacing: 3) {
              ForEach(genreNames(for: tv.genre_ids), id: \.self) { genreName in
                Text(genreName)
                  .padding(.horizontal, 10)
                  .padding(.vertical, 5)
                  .background(Color.gray.opacity(0.4))
                  .foregroundStyle(.white)
                  .font(.subheadline)
                  .cornerRadius(25.0)
                  .lineLimit(1)
              }
            }
            .padding(.bottom, 15)
            
            Text("Overview")
              .foregroundStyle(.white)
              .font(.title3)
            
            Text(tv.overview)
              .font(.body)
              .foregroundColor(.white)
              .lineLimit(nil)
              .padding(.bottom, 15)
            
            HStack {
              Text("Stars")
                .foregroundStyle(.white)
                .font(.title3)
              
              Image(systemName: "star")
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            
            HStack {
              Text("Production companies")
                .foregroundStyle(.white)
                .font(.title3)
              
              Image(systemName: "house.fill")
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            
          }
          .padding()
        }
      }
    }
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
    .onAppear {
      Task {
        try await vm.getTVDetail(id: 1396)
      }
    }
  }
}

#Preview {
  TVDetailView(tv: TV(id: 1396,
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
