//
//  ViewButtons.swift
//  TMBD
//
//  Created by Dan FuPo on 07/01/24.
//

import SwiftUI

struct ViewButtons: View {
  var action: () -> Void
  var systemName: String
  
  var body: some View {
    Button(action: {
      action()
    }, label: {
      Circle()
        .fill(Color.gray.opacity(0.3))
        .frame(width: 50, height: 50)
        .shadow(radius: 10)
        .overlay(
          Image(systemName: systemName)
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold))
        )
    })
  }
}

#Preview {
  ViewButtons(action: {}, systemName: "xmark")
}
