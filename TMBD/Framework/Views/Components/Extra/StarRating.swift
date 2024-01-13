//
//  StarRating.swift
//  TMBD
//
//  Created by Dan FuPo on 06/01/24.
//

import SwiftUI

struct StarRating: View {
  
  var value: Double
  var maxValue = 5
  var wholeStars: Int
  var halfStar = false
  var emptyStars: Int
  
  init(_ value: Double) {
    self.value = value
    self.wholeStars = Int(floor(value))
    
    if value - Double(wholeStars) >= 0.5 {
      self.halfStar = true
    }
    
    if self.halfStar {
      emptyStars = maxValue - wholeStars - 1
    } else {
      emptyStars = maxValue - wholeStars
    }
  }
  
  var body: some View {
    
    HStack(alignment: .center, spacing: 2) {
      ForEach(0..<wholeStars,
              id: \.self) { star in
        Image(systemName: "star.fill")
          .resizable()
          .scaledToFit()
      }
      
      if halfStar {
        Image(systemName: "star.leadinghalf.fill")
          .resizable()
          .scaledToFit()
      }
      
      ForEach(0..<emptyStars,
              id: \.self) { star in
        Image(systemName: "star")
          .resizable()
          .scaledToFit()
      }
    }
    .foregroundStyle(Color(.yellow))
  }
}

#Preview {
  StarRating(5)
}
