//
//  CreatedByCard.swift
//  TMBD
//
//  Created by Dan FuPo on 13/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreatedByCard: View {
  var person: CreatedBy
  
  var body: some View {
    VStack(alignment: .leading) {
      // Crew Image
      WebImage(url: person.fullProfile)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(5)
        .frame(width: 100, height: 150)
      
      // Crew Name
      Text(person.name)
        .font(.headline)
        .lineLimit(3)
        .multilineTextAlignment(.leading)
        .foregroundStyle(.white)
      
      // Creator
      Text("as Creator")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    .frame(width: 100)
  }
}

#Preview {
  CreatedByCard(person: CreatedBy(id: 2000007,
                                  name: "Christian Linke",
                                  profile_path: "/yTYR4W1ORuSBoVPjnkGafNPKQDc.jpg"))
}
