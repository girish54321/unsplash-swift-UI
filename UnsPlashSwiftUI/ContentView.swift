//
//  ContentView.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 01/05/22.
//

import SwiftUI
import AlertToast

struct ContentView: View {
    
    @EnvironmentObject var appStateStorage: AppStateStorage
    @EnvironmentObject var viewModel: AlertViewModel
    
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
        .overlay {
            if appStateStorage.isLoadingViewShowing == true {
                LoadingIndicator()
            } else {
                VStack{}
            }
        }
        .toast(isPresenting: $viewModel.show){
            viewModel.alertToast
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
