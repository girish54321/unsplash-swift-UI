//
//  DownloadImage.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 03/05/22.
//

import SwiftUI

struct DownloadImage: View {
    
    var url: Urls = Urls(raw: "", full: "", regular: "", small: "", thumb: "")
    
    let url1 = DownlodClass(title: "Small", subTitle: "Smallest size", url: "", size: "1MB+",color: .blue)
    let url2 = DownlodClass(title: "Regular", subTitle: "For mobile wallpaper", url:"", size: "3MB+",color: .yellow)
    let url3 = DownlodClass(title: "Full", subTitle: "For Desktop", url:  "", size: "6MB+",color: .orange)
    let url4 = DownlodClass(title: "Raw", subTitle: "Original file", url:  "", size: "10MB+",color: .red)
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach([url1,url2,url3,url4], id: \.self){ item in
                    DownloadListItem(title: item.title, des: item.subTitle, size: item.size,color: item.color)
                }
            }
            .navigationTitle("Download Image")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(
                trailing:
                    NavigationLink(destination:
                                    Text("Search")
                                  ) {
                                      Image(systemName: "xmark")
                                  }
            )
        }
    }
}

struct DownloadImage_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImage()
    }
}
