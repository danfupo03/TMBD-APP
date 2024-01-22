//
//  Status.swift
//  TMBD
//
//  Created by Dan FuPo on 16/01/24.
//

import Foundation
import SwiftUI

/// <#Description#>
/// - Parameter status: <#status description#>
/// - Returns: <#description#>
func getStatusColor(status: String) -> Color {
  switch status {
  case "Ended":
    return .blue
  case "Returning Series":
    return .green
  case "Canceled":
    return .red
  default:
    return .white
  }
}
