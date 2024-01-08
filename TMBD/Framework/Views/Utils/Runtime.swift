//
//  Runtime.swift
//  TMBD
//
//  Created by Dan FuPo on 07/01/24.
//

import Foundation

func runtimeFormatter(runtime: Int) -> String {
  var result: Int
  
  result = runtime / 60
  
  if result > 0 {
    return "\(result)h \(runtime % 60)m"
  } else {
    return "\(runtime % 60)m"
  }
}
