//
//  CoordinatorView.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import SwiftUI

struct LoginView: View {
  @State var email = ""
  @StateObject var vm = LoginViewModel()
  
  var body: some View {
    VStack(alignment: .center) {
      Spacer().frame(height: 48)
      
      Text("Hola de nuevo").font(.largeTitle)
      
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
      } label: {
        Text("Acceder")
      }
    } .padding()
      .alert(isPresented: $vm.showAlert) {
        Alert(
          title: Text("Oops!"),
          message: Text(vm.messageAlert)
        )
      }
  }
}

#Preview {
  LoginView()
}
