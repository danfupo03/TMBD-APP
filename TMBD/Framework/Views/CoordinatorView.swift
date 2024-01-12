//
//  CoordinatorView.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import FlowStacks
import SwiftUI

struct CoordinatorView: View {
  
  enum Screen {
    case login
    case menu
  }
  
  @State var routes: Routes<Screen> = [.root(.login)]
  
  var body: some View {
    Router($routes) { screen, _ in
      switch screen {
      case .login:
        LoginView(
          goMenu: { routes.presentCover(.menu) }
        ).preferredColorScheme(.light)
      case .menu:
        TabBar(
          goRoot: { routes.presentCover(.login) }
        ).preferredColorScheme(.light)
      }
    }
  }
  
  private func goRoot() {
    Task { @MainActor in
      await $routes.withDelaysIfUnsupported {
        $0.goBackToRoot()
      }
    }
  }
}
