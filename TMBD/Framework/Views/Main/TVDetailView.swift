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
  @State private var showingSheet = false
  
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
              
              let seasons = vm.detailTV.number_of_seasons
              let textSeasons = String(seasons)
              
              Text("\(textSeasons) seasons")
                .font(.subheadline)
                .foregroundStyle(.white)
              
              Text("·")
                .font(.subheadline)
                .foregroundStyle(.white)
              
              Button("Episodes") {
                showingSheet.toggle()
              }
              
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
            
            Text("Status")
              .foregroundStyle(.white)
              .font(.title3)
            
            Text(vm.detailTV.status)
              .font(.body)
              .foregroundColor(.white)
              .lineLimit(nil)
              .padding(.bottom, 15)
            
            HStack {
              Text("Stars")
                .foregroundStyle(.white)
                .font(.title3)
              
              Image(systemName: "star.circle")
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            
            HStack {
              Text("Screenplay")
                .foregroundStyle(.white)
                .font(.title3)
              
              Image(systemName: "movieclapper")
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
              LazyHStack (spacing: 20) {
                ForEach(vm.detailTV.created_by) { person in
                  CreatedByCard(person: person)
                }
              }
            }
            .padding(.bottom, 15)
            
            HStack {
              Text("Production companies")
                .foregroundStyle(.white)
                .font(.title3)
              
              Image(systemName: "house.fill")
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            
            HStack {
              Text(vm.detailTV.production_companies.map { $0.name }.joined(separator: ", "))
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            .padding(.bottom, 15)
            
          }
          .padding()
        }
      }
    }
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
    .sheet(isPresented: $showingSheet) {
      TVEpisodes()
    }
    .onAppear {
      Task {
        try await vm.getTVDetail(id: tv.id)
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
