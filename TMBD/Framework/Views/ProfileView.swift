//
//  ProfileView.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import SwiftUI

struct ProfileView: View {
  @StateObject var vm = ProfileViewModel()
  let goRoot: () -> Void
  
  var body: some View {
    VStack(alignment: .center, spacing: 24) {
      Text(vm.email)
      
      Button {
        vm.logOut()
        goRoot()
      } label: {
        HStack(spacing: 16) {
          Image(systemName: "power")
          Text("Logout")
        }.foregroundColor(.red)
      }
    }.onAppear {
      vm.getCurrentUser()
    }
  }
}

#Preview {
  ProfileView(goRoot: {})
}
