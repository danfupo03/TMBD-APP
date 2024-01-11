//
//  CoordinatorView.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import SwiftUI
import FlowStacks

/// Main view to manage navigation flow on different presentations mode
struct CoordinatorView: View {
  /// Use this variable to set the main screen the app should start
  @State var routes: Routes<Screen> = [.root(.login)]
  
  /// It's not necessary to add all screens. Check up the side menu to understand whole navigation
  enum Screen {
    case login
    case menu
  }
  
  var body: some View {
    Router($routes) { screen, _ in
      /// For each screen setup the corresponding view
      switch screen {
      case .login:
        /// Setup page/view will be shown when referring this case
        LoginView(
          /// The function `goMenu` is declared in LoginView, we use it to send the action to present a specific screen
          /// Set up the route screen and the presenting mode for the flow desired
          goMenu: { routes.presentCover(.menu) }
        )
      case .menu:
        ContentView(
          goRoot: { routes.presentCover(.login) }
        )
      }
    }
  }
  
  /// Return to main screen [eg. Logout] that returns to first screen in flow
  private func goRoot() {
    Task { @MainActor in
      await $routes.withDelaysIfUnsupported {
        $0.goBackToRoot()
      }
    }
  }
}
