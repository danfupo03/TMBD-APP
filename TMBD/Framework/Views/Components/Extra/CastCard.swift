//
//  CastCard.swift
//  TMBD
//
//  Created by Dan FuPo on 08/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CastCard: View {
  var cast: Cast
  
  var body: some View {
    VStack(alignment: .leading) {
      // Actor Image
      WebImage(url: cast.fullProfilePath)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(5)
        .frame(width: 100, height: 150)
      
      // Actor Name
      Text(cast.name)
        .font(.headline)
        .lineLimit(3)
        .multilineTextAlignment(.leading)
        .foregroundStyle(.white)
      
      // Known Department
      Text("as \(cast.character)")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    .frame(width: 100)
  }
}

#Preview {
  CastCard(cast: Cast(adult: false,
                      gender: 2,
                      id: 2037,
                      known_for_department: "Acting",
                      name: "Cillian Murphy",
                      original_name: "Cillian Murphy",
                      popularity: 96.732,
                      profile_path: "/2lKs67r7FI4bPu0AXxMUJZxmUXn.jpg",
                      character: "J. Robert Oppenheimer"))
}
