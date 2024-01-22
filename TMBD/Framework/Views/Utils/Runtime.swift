//
//  Runtime.swift
//  TMBD
//
//  Created by Dan FuPo on 07/01/24.
//

import Foundation

/// <#Description#>
/// - Parameter runtime: <#runtime description#>
/// - Returns: <#description#>
func runtimeFormatter(runtime: Int) -> String {
  var result: Int
  
  result = runtime / 60
  
  if result > 0 {
    return "\(result)h \(runtime % 60)min"
  } else {
    return "\(runtime % 60)min"
  }
}
