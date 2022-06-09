//
//  LoadingIndicator.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 04/06/22.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingIndicator: View {
    @State private var loading = true
    var body: some View {
        VStack {
            ActivityIndicatorView(isVisible: $loading,
                                  type: .growingArc(.accentColor, lineWidth: 4)
            )
            .foregroundColor(.accentColor)
            .frame(width: 50, height: 50)
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
