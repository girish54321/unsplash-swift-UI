//
//  ContentView.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 01/05/22.
//

import SwiftUI

struct RedView: View {
    var body: some View {
        Color.red
    }
}
struct BlueView: View {
    var body: some View {
        Color.blue
    }
}



struct ContentView: View {
    var body: some View {
        TabView {
            HomeScreen()
             .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
           }
            HotImageScreen()
             .tabItem {
                Image(systemName: "flame.fill")
                Text("Tranding")
          }
            TopicsScreen()
              .tabItem {
                 Image(systemName: "menucard.fill")
                 Text("Topices")
           }
            SavedImagesScreen()
              .tabItem {
                 Image(systemName: "square.and.arrow.down.fill")
                 Text("Saved")
           }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
