//
//  LoadingListView.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 04/06/22.
//

import SwiftUI
import WaterfallGrid

struct LoadingListView: View {
    var body: some View {
        VStack {
            HStack {
            LoadingView()
            LoadingView()
            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 6, trailing: 8))
            HStack {
            LoadingView()
            LoadingView()
            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 6, trailing: 8))
            HStack {
            LoadingView()
            LoadingView()
            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 6, trailing: 8))
        }
    }
}

struct LoadingListView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingListView()
    }
}
