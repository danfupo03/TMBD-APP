//
//  CoordinatorView.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import SwiftUI

struct LoginView: View {
  @StateObject var vm = LoginViewModel()
  
  /// Used by the coordinator to manage the flow
  let goMenu: () -> Void
  
  var body: some View {
    VStack(alignment: .center) {
      Spacer().frame(height: 48)
      
      Text("Movie App").font(.largeTitle)
      
      Spacer()
      
      VStack(spacing: 0) {
        TextField(text: $vm.email) {
          Text("Correo Electrónico")
        }.multilineTextAlignment(.center)
          .keyboardType(.emailAddress)
          .padding()
          .font(.title3)
          .textInputAutocapitalization(.never)
        
        Divider()
      }
      
      Spacer()
      
      Button {
        vm.setCurrentUser()
        goMenu()
      } label: {
        Text("Acceder")
      }
    }.onAppear {
      vm.getCurrentUser()
      
      if vm.email != "" {
        goMenu()
      }
    }.padding()
      .alert(isPresented: $vm.showAlert) {
        Alert(
          title: Text("Oops!"),
          message: Text(vm.messageAlert)
        )
      }
  }
}

#Preview {
  LoginView(goMenu: {})
}
