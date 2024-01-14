//
//  TVEpisodes.swift
//  TMBD
//
//  Created by Dan FuPo on 13/01/24.
//

import SwiftUI

struct TVEpisodes: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    
    Button("Press to dismiss") {
      dismiss()
    }
    .font(.title)
    .padding()
    .background(.black)
  }
}

#Preview {
  TVEpisodes()
}
