//
//  TMBDApp.swift
//  TMBD
//
//  Created by Dan FuPo on 10/10/23.
//

import SwiftUI

@main
struct TMBDApp: App {
  @Environment(\.scenePhase) var scenePhase
  
  var body: some Scene {
    WindowGroup {
      CoordinatorView()
    }.onChange(of: scenePhase) { (newScenePhase) in
      switch newScenePhase {
      case .background:
        print("App State : Background")
      case .inactive:
        print("App State : Inactive")
      case .active: // Foreground
        print("App State : Active")
      @unknown default:
        print("App State : Unknown")
      }
    }
  }
}
