//
//  ContentView.swift
//  ExList
//
//  Created by 김종권 on 2022/08/16.
//

import SwiftUI

struct Ocean: Identifiable {
  let name: String
  let id = UUID()
}

struct ContentView: View {
  @State private var multiSelection = Set<UUID>()
  
  private var oceans = [
    Ocean(name: "Pacific"),
    .init(name: "Atlantic"),
    .init(name: "Indian"),
    .init(name: "Southern"),
    .init(name: "Arctic"),
  ]
  
  var body: some View {
    // MARK: Basic
//    List {
//      Text("A List Item")
//      Text("A Second List Item")
//      Text("A Third List Item")
//    }
    
    // MARK: Selections
    NavigationView {
      List(oceans, selection: $multiSelection) {
        Text($0.name)
      }
      .navigationTitle("Oceans")
      .toolbar { EditButton() }
    }
    Text("\(multiSelection.count) selections")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
