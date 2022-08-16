//
//  ContentView.swift
//  ExList
//
//  Created by 김종권 on 2022/08/16.
//

import SwiftUI

struct Ocean: Identifiable {
  var name: String
  let id = UUID()
}

struct ContentView: View {
  @State private var multiSelection = Set<UUID>()
  @State private var isOn = false
  
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
//    NavigationView {
//      List(oceans, selection: $multiSelection) {
//        Text($0.name)
//      }
//      .navigationTitle("Oceans")
//      .toolbar { EditButton() }
//    }
//    Text("\(multiSelection.count) selections")
    
    // MARK: Refresh
    NavigationView {
      VStack {
        List(oceans, selection: $multiSelection) {
          Text($0.name)
        }
        .navigationTitle("Oceans")
        .refreshable {
          await getSomeData()
        }
        Toggle("Toggle", isOn: $isOn)
      }
    }
  }
  
  func getSomeData() async {
    await Task.sleep(3_000_000_000) // 3seconds
    isOn.toggle()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
