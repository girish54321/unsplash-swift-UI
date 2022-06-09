//
//  AppToastView.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 08/06/22.
//

import SwiftUI

struct AppToastView: View {
    
    @StateObject var viewModel: AlertViewModel
    
    var body: some View {
        HStack { 
            HStack {
                Image(systemName: "checkmark.circle")
                    .imageModifier()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.accentColor)
                    .padding(.trailing, 8)
                VStack(spacing: 6) {
                    HStack {
                        Text(viewModel.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    HStack {
                        Text(viewModel.subTitle)
                        Spacer()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.background)
            .cornerRadius(8.0)
        .shadow(radius: 4.0)
        }
        .padding()
    }
}

//struct AppToastView_Previews: PreviewProvider {
//    @EnvironmentObject var viewModel: AlertViewModel
//    static var previews: some View {
//        AppToastView(viewModel: viewModel)
//    }
//}
