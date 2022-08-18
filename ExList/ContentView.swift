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

struct Sea: Hashable, Identifiable {
  let name: String
  let id = UUID()
}

struct OceanRegion: Identifiable {
  let name: String
  let seas: [Sea]
  let id = UUID()
}

struct FileItem: Hashable, Identifiable, CustomStringConvertible {
  var id: Self { self }
  var name: String
  var children: [FileItem]? = nil
  var description: String {
    switch children {
    case nil:
      return "📄 \(name)"
    case .some(let children):
      return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
    }
  }
}

struct ContentView: View {
  @State private var multiSelection = Set<UUID>()
  @State private var isOn = false
  @State private var singleSelection: UUID?
  
  private var oceans = [
    Ocean(name: "Pacific"),
    .init(name: "Atlantic"),
    .init(name: "Indian"),
    .init(name: "Southern"),
    .init(name: "Arctic"),
  ]
  
  private let oceanRegions: [OceanRegion] = [
    OceanRegion(name: "Pacific",
                seas: [Sea(name: "Australasian Mediterranean"),
                       Sea(name: "Philippine"),
                       Sea(name: "Coral"),
                       Sea(name: "South China")]),
    OceanRegion(name: "Atlantic",
                seas: [Sea(name: "American Mediterranean"),
                       Sea(name: "Sargasso"),
                       Sea(name: "Caribbean")]),
    OceanRegion(name: "Indian",
                seas: [Sea(name: "Bay of Bengal")]),
    OceanRegion(name: "Southern",
                seas: [Sea(name: "Weddell")]),
    OceanRegion(name: "Arctic",
                seas: [Sea(name: "Greenland")])
  ]
  
  let fileHierarchyData: [FileItem] = [
    FileItem(name: "users", children:
              [FileItem(name: "user1234", children:
                          [FileItem(name: "Photos", children:
                                      [FileItem(name: "photo001.jpg"),
                                       FileItem(name: "photo002.jpg")]),
                           FileItem(name: "Movies", children:
                                      [FileItem(name: "movie001.mp4")]),
                           FileItem(name: "Documents", children: [])
                          ]),
               FileItem(name: "newuser", children:
                          [FileItem(name: "Documents", children: [])
                          ])
              ]),
    FileItem(name: "private", children: nil)
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
    //    NavigationView {
    //      VStack {
    //        List(oceans, selection: $multiSelection) {
    //          Text($0.name)
    //        }
    //        .navigationTitle("Oceans")
    //        .refreshable {
    //          await getSomeData()
    //        }
    //        Toggle("Toggle", isOn: $isOn)
    //      }
    //    }
    
    // MARK: Section
    //    NavigationView {
    //      List(selection: $singleSelection) {
    //        ForEach(oceanRegions) { region in
    //          Section(
    //            content: {
    //              ForEach(region.seas) { sea in
    //                Text(sea.name)
    //              }
    //            },
    //            header: {
    //              Text("Header \(region.name)")
    //            }
    //          )
    //        }
    //      }
    //    }
    
    // MARK: Hierarchical List
    List(fileHierarchyData, children: \.children) { item in
      Text(item.description)
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

