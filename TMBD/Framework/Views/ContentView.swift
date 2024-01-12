//
//  ContentView.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import SwiftUI

struct ContentView: View {
  let goRoot: () -> Void
  
  var body: some View {
    TabBar(goRoot: goRoot)
      .preferredColorScheme(.light)
  }
}

#Preview {
  ContentView(goRoot: {})
}
