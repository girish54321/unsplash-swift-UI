//
//  SelectedImage.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 02/05/22.
//

import SwiftUI
import BottomSheetSwiftUI

struct SelectedImage: View {
    
    var image: SelectedImageClass
    @State private var isShowingSettings: Bool = false
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string:  image.urls?.small ?? "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80"), transaction: Transaction(animation: .spring())) { phase in
                switch phase {
                case .empty:
                    Color.purple.opacity(0.1)
                case .success(let image):
                    image
                        .imageModifier()
                        .transition(.slide)
                case .failure(_):
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    Image(systemName: "exclamationmark.icloud")
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingSettings = true
                    }, label: {
                        Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 57, height: 50)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    })
                    .background(Color.blue)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                    .sheet(isPresented: $isShowingSettings) {
                        DownloadImage()
                    }
                }
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .navigationBarTitle(Text(image.description ?? "NA"),displayMode: .inline)
    }
}

struct SelectedImage_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        SelectedImage(image: SelectedImageClass(id: "", createdAt: nil, updatedAt: nil, promotedAt: nil, width: nil, height: 12, color: "", blur_hash: "", homeImageDescription: "", altDescription: "", description: "", urls: Urls(raw: "", full: "", regular: "", small: nil, thumb: ""), user: nil, categories: nil))
    }
}
