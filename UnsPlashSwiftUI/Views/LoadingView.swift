//
//  LoadingView.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 28/05/22.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingView: View {
    @State var isAnimating = false
    var body: some View {
            Rectangle()
                .fill(Color.pink)
                .frame(width: .infinity, height: 280)
                .opacity(isAnimating ? 0.3 : 1)
                .onAppear {
                    withAnimation(Animation.linear(duration: 1).repeatForever()){
                        isAnimating = true
                    }
                }
    }
}

struct LoadingView_Previews: PreviewProvider {
    @State static var mhzValue : Bool = true // Good
    static var previews: some View {
        LoadingView()
    }
}
