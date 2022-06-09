//
//  ContentView.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 01/05/22.
//

import SwiftUI
import AlertToast
import SPAlert
import ToastUI

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
                EmptyView()
            }
        }
        .toast(isPresented: $viewModel.show, dismissAfter: 2.0) {
            print("Toast dismissed")
        } content: {
            VStack {
                Spacer()
                AppToastView(viewModel: viewModel)
                    .environmentObject(AlertViewModel())
            }
        }
//        .toast(isPresenting: $viewModel.show){
//            viewModel.alertToast
//        }
//        .SPAlert(
//            isPresent: $viewModel.show,
//            title: "Alert title",
//            message: "Alert message",
//            duration: 2.0,
//            dismissOnTap: true,
//            preset: .done,
//            haptic: .success,
//            layout: .init(),
//            completion: {
//                print("Alert is destory")
//            })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
