//
//  PeopleList.swift
//  TMBD
//
//  Created by Dan FuPo on 17/01/24.
//

import SwiftUI

struct PeopleList: View {
  @StateObject var vm = PeopleViewModel()
  @State private var isLoading = false
  @State private var showingSheet = false
  @State private var selectedPerson: People?
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          
          //Trending people
          Text("Trending people").font(.title).fontWeight(.bold)
          
          let peoplePairs = vm.popularPeople.chunked(into: 2)
          
          Grid {
            ForEach(peoplePairs, id: \.self) { peoplePair in
              GridRow {
                ForEach(peoplePair, id: \.id) { person in
                  PeopleCard(person: person)
                    .onTapGesture {
                      selectedPerson = person
                      showingSheet = true
                    } .padding(.bottom, 8)
                }
              }
            }
          }
          
        }
        .padding()
      }
    }
    .sheet(isPresented: $showingSheet) {
      if let selectedPerson = selectedPerson {
        PeopleDetailView(person: selectedPerson)
      }
    }
    .onAppear {
      Task {
        await vm.getPopular(pages: 2)
      }
    }
  }
}

extension Array {
  func chunked(into size: Int) -> [[Element]] {
    return stride(from: 0, to: count, by: size).map {
      Array(self[$0..<Swift.min($0 + size, count)])
    }
  }
}

#Preview {
  PeopleList()
}
