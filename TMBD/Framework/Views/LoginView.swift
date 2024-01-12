//
//  CoordinatorView.swift
//  TMBD
//
//  Created by Dan FuPo on 11/01/24.
//

import SwiftUI

struct LoginView: View {
  @StateObject var vm = LoginViewModel()
  
  let goMenu: () -> Void
  
  var body: some View {
    VStack(alignment: .leading) {
      Image("TMDB_logo")
        .resizable()
        .frame(width: 139.13, height: 100)
      
      Spacer().frame(height: 48)
      
      Text("Welcome Back,")
        .font(.title).fontWeight(.bold)
      
      Text("sign in to continue watching")
        .font(.title3)
        .foregroundColor(Color(red: 0.54, green: 0.54, blue: 0.54))
      
      Spacer()
      
      VStack(spacing: 0) {
        TextField(text: $vm.email) {
          Text("Email")
        }
        .multilineTextAlignment(.leading)
        .keyboardType(.emailAddress)
        .padding()
        .font(.title3)
        .textInputAutocapitalization(.never)
        
        Divider().overlay(.black)
          .padding(.bottom, 40)
        
        SecureField(text: $vm.password) {
          Text("Password")
        }
        .multilineTextAlignment(.leading)
        .keyboardType(.emailAddress)
        .padding()
        .font(.title3)
        .textInputAutocapitalization(.never)
        
        Divider().overlay(.black)
      }
      
      Spacer()
      
      HStack {
        Spacer()
        Button {
          vm.setCurrentUser()
          goMenu()
        } label: {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 270, height: 50)
            .background(Color(red: 0.05, green: 0.18, blue: 0.28))
            .cornerRadius(30)
            .overlay(
              Text("Log In").foregroundStyle(.white)
            )
        }
        Spacer()
      }
      
    }.onAppear {
      vm.getCurrentUser()
      
      if vm.email != "" {
        goMenu()
      }
    }
    .padding()
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
