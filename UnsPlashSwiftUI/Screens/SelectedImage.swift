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
                        Image("download")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38)
                            .padding()
                    })
                    .background(Color.white)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                    .sheet(isPresented: $isShowingSettings) {
                            let url1 = DownlodClass(title: "Small", subTitle: "Smallest size", url: "", size: "1MB+",color: .blue)
                            let url2 = DownlodClass(title: "Regular", subTitle: "For mobile wallpaper", url:"", size: "3MB+",color: .yellow)
                            let url3 = DownlodClass(title: "Full", subTitle: "For Desktop", url:  "", size: "6MB+",color: .orange)
                            let url4 = DownlodClass(title: "Raw", subTitle: "Original file", url:  "", size: "10MB+",color: .red)
                        DownloadImage(url1: url1, url2: url2, url3: url3, url4: url4)
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
        Group {
            SelectedImage(image: SelectedImageClass(id: "", createdAt: nil, updatedAt: nil, promotedAt: nil, width: nil, height: 12, color: "", blur_hash: "", homeImageDescription: "", altDescription: "", description: "", urls: Urls(raw: "", full: "", regular: "", small: nil, thumb: ""), user: nil, categories: nil))
        }
    }
}
