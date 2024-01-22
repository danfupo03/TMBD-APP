//
//  Tab.swift
//  TMBD
//
//  Created by Dan FuPo on 03/12/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
  case movies = "Movies"
  case series = "Series"
  case actors = "Actors"
  
  var systemImage: String {
    switch self {
    case .movies:
      return "movieclapper"
    case .series:
      return "tv"
    case .actors:
      return "star.circle"
    }
  }
  
  var index: Int {
    return Tab.allCases.firstIndex(of: self) ?? 0
  }
}
