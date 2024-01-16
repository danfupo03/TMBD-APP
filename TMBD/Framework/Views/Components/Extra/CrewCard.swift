//
//  CrewCard.swift
//  TMBD
//
//  Created by Dan FuPo on 08/01/24.
//

import SwiftUI

import SwiftUI
import SDWebImageSwiftUI

struct CrewCard: View {
  var crew: Crew
  
  var body: some View {
    VStack(alignment: .leading) {
      // Crew Image
      WebImage(url: crew.fullProfilePath)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(5)
        .frame(width: 100, height: 150)
      
      // Crew Name
      Text(crew.name)
        .font(.headline)
        .lineLimit(3)
        .multilineTextAlignment(.leading)
        .foregroundStyle(.white)
      
      // Known Department
      Text("as \(crew.job)")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    .frame(width: 100)
  }
}

#Preview {
  CrewCard(crew: Crew(adult: false,
                        gender: 2,
                        id: 525,
                        known_for_department: "Directing",
                        name: "Christopher Nolan",
                        original_name: "Christopher Nolan",
                        popularity: 46.156,
                        profile_path: "/xuAIuYSmsUzKlUMBFGVZaWsY3DZ.jpg",
                        job: "Director"))
}
