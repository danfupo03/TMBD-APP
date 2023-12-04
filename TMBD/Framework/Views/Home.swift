//
//  Home.swift
//  TMBD
//
//  Created by Dan FuPo on 03/12/23.
//

import SwiftUI

struct Home: View {
  @State private var activeTab: Tab = .home
  
  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: $activeTab) {
        Text("Home")
          .tag(Tab.home)
          .toolbar(.hidden, for: .tabBar)
        
        Text("Services")
          .tag(Tab.services)
          .toolbar(.hidden, for: .tabBar)
        
        Text("Partners")
          .tag(Tab.partners)
          .toolbar(.hidden, for: .tabBar)
        
        Text("Activity")
          .tag(Tab.activity)
          .toolbar(.hidden, for: .tabBar)
      }
      
      CustomTabBar()
    }
  }
  
  @ViewBuilder
  func CustomTabBar(_ tint: Color = Color("Blue"), _ inactiveTint: Color = .blue) -> some View {
    HStack(spacing: 0) {
      ForEach(Tab.allCases, id: \.rawValue) {
        TabItem(
          tint: tint,
          inactiveTint: inactiveTint,
          tab: $0,
          activeTab: $activeTab)
      }
    }
    
  }
}

struct TabItem: View {
  var tint: Color
  var inactiveTint: Color
  var tab: Tab
  @Binding var activeTab: Tab
  
  var body: some View {
    VStack(spacing: 0) {
      Image(systemName: tab.systemImage)
        .font(.title2)
        .frame(width: 35, height: 35)
      
      Text(tab.rawValue)
        .font(.caption)
        .foregroundStyle(.gray)
    }
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  ContentView()
}
