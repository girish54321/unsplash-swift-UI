//
//  UnsPlashSwiftUIApp.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 01/05/22.
//

import SwiftUI

@main
struct UnsPlashSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(AlertViewModel())
        }
    }
}
