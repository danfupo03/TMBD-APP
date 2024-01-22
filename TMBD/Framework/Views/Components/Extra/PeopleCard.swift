//
//  PeopleCard.swift
//  TMBD
//
//  Created by Dan FuPo on 17/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PeopleCard: View {
  var person: People
  
  var body: some View {
    VStack(alignment: .leading) {
      // Poster Image
      if person.profile_path == nil {
        WebImage(url: URL(string: "https://media.istockphoto.com/id/1402985768/vector/pictogram-of-a-standing-person.jpg?s=612x612&w=0&k=20&c=c_ddVP2Dequ7CsQ_KKTSXVF628GueXTE5TxkRBk0eYQ="))
          .resizable()
          .aspectRatio(contentMode: .fit)
      } else {
        WebImage(url: person.profile)
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      
      // Movie Title
      Text(person.name)
        .font(.headline)
        .lineLimit(5)
        .multilineTextAlignment(.leading)
      
      // Release Date
      Text(person.known_for_department)
        .font(.subheadline)
        .foregroundColor(.gray)
      
    }
    .frame(minWidth: 0, maxWidth: 150, minHeight: 0, maxHeight: .infinity)
    .padding()
    .cornerRadius(15)
  }
}

#Preview {
  PeopleCard(person: People(id: 54693,
                            gender: 2,
                            known_for_department: "Acting",
                            name: "Emma Stone",
                            popularity: 192.542,
                            profile_path: "/3UaYw9KF4fEXRMRWhf25aGJpAW2.jpg",
                            known_for: []))
}
