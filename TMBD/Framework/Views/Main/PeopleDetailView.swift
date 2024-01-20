//
//  PeopleDetailView.swift
//  TMBD
//
//  Created by Dan FuPo on 19/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PeopleDetailView: View {
  var person: People
  
  @StateObject var vm = PeopleViewModel()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ScrollView {
      VStack {
        
        ZStack(alignment: .top) {
          
          // Poster
          WebImage(url: person.profile)
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
          
          let popularity = person.popularity
          let popularityText = String(format: "%.1f", person.popularity)
          
          VStack(alignment: .leading, spacing: 10) {
            
            HStack {
              Text("Popularity: ")
                .foregroundStyle(.white)
              
              Text(popularityText)
                .foregroundStyle(popularity > 200 ? .blue : (popularity > 150 ? .green : (popularity > 100 ? .yellow : .red)))
              
              Text(Image(systemName: "chart.bar.fill"))
                .font(.subheadline)
                .foregroundStyle(popularity > 200 ? .blue : (popularity > 150 ? .green : (popularity > 100 ? .yellow : .red)))
            }
            .padding(.bottom, 10)
            
            Text(person.name)
              .font(.title)
              .foregroundColor(.white)
            
            HStack {
              
              if vm.detailPerson.deathday != nil {
                Text(vm.detailPerson.birthday)
                  .font(.subheadline)
                  .foregroundColor(.white)
                
                Text("-")
                  .font(.subheadline)
                  .foregroundStyle(.white)
                
                Text(vm.detailPerson.deathday ?? "")
                  .font(.subheadline)
                  .foregroundColor(.white)
              } else {
                
                Text(vm.detailPerson.birthday)
                  .font(.subheadline)
                  .foregroundColor(.white)
              }
            }
            .padding(.bottom, 15)
            
            Text("Overview")
              .foregroundStyle(.white)
              .font(.title3)
            
            Text(vm.detailPerson.place_of_birth)
              .foregroundStyle(.white)
              .font(.subheadline)
              .padding(.bottom, 15)
            
            Text(vm.detailPerson.biography)
              .font(.body)
              .foregroundColor(.white)
              .lineLimit(nil)
              .padding(.bottom, 15)
            
            HStack {
              Text("Known for")
                .foregroundStyle(.white)
                .font(.title3)
              
              Image(systemName: "movieclapper")
                .foregroundStyle(.white)
                .font(.subheadline)
            }
            
              ForEach(person.known_for, id: \.id) { content in
                HStack {
                  if content.media_type == "movie" {
                    Text("· \(content.title ?? "")")
                      .foregroundStyle(.white)
                      .font(.subheadline)
                    
                    Image(systemName: "movieclapper")
                      .foregroundStyle(.white)
                      .font(.subheadline)
                  }
                  
                  if content.media_type == "tv" {
                    Text("· \(content.title ?? "Name not available")")
                      .foregroundStyle(.white)
                      .font(.subheadline)
                    
                    Image(systemName: "tv")
                      .foregroundStyle(.white)
                      .font(.subheadline)
                  }
                }
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
        try await vm.getPerson(id: person.id)
      }
    }
  }
}

#Preview {
  PeopleDetailView(person: People(id: 54693,
                                  gender: 2,
                                  known_for_department: "Acting",
                                  name: "Emma Stone",
                                  popularity: 192.542,
                                  profile_path: "/3UaYw9KF4fEXRMRWhf25aGJpAW2.jpg",
                                  known_for: [
                                    KnownFor(id: 337404,
                                             backdrop_path: "/kmuSGNlF9mfNHIDOEVEWPj6f3Ak.jpg",
                                             title: "Cruella",
                                             overview: "In 1970s London amidst the punk rock revolution, a young grifter named Estella is determined to make a name for herself with her designs. She befriends a pair of young thieves who appreciate her appetite for mischief, and together they are able to build a life for themselves on the London streets. One day, Estella’s flair for fashion catches the eye of the Baroness von Hellman, a fashion legend who is devastatingly chic and terrifyingly haute. But their relationship sets in motion a course of events and revelations that will cause Estella to embrace her wicked side and become the raucous, fashionable and revenge-bent Cruella.",
                                             poster_path: "/wToO8opxkGwKgSfJ1JK8tGvkG6U.jpg",
                                             media_type: "movie",
                                             genre_ids: [35, 80],
                                             release_date: "2021-05-26",
                                             popularity: 76.628,
                                             vote_average: 8.0),
                                    KnownFor(id: 1930,
                                             backdrop_path: "/sxskOU71CO8LaNX2LOtjYFUtKv7.jpg",
                                             title: "The Amazing Spider-Man",
                                             overview: "Peter Parker is an outcast high schooler abandoned by his parents as a boy, leaving him to be raised by his Uncle Ben and Aunt May. Like most teenagers, Peter is trying to figure out who he is and how he got to be the person he is today. As Peter discovers a mysterious briefcase that belonged to his father, he begins a quest to understand his parents' disappearance – leading him directly to Oscorp and the lab of Dr. Curt Connors, his father's former partner. As Spider-Man is set on a collision course with Connors' alter ego, The Lizard, Peter will make life-altering choices to use his powers and shape his destiny to become a hero.",
                                             poster_path: "/jIfkQNARYyERqRAq1p1c8xgePp4.jpg",
                                             media_type: "movie",
                                             genre_ids: [28, 12, 78],
                                             release_date: "2012-06-23",
                                             popularity: 71.897,
                                             vote_average: 6.696)]))
}
