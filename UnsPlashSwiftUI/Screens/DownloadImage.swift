//
//  DownloadImage.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 03/05/22.
//

import SwiftUI

struct DownloadImage: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var url1: DownlodClass
    var url2: DownlodClass
    var url3: DownlodClass
    var url4: DownlodClass
    
    //    var url1 = DownlodClass(title: "Small", subTitle: "Smallest size", url: "", size: "1MB+",color: .blue)
    //    var url2 = DownlodClass(title: "Regular", subTitle: "For mobile wallpaper", url:"", size: "3MB+",color: .yellow)
    //    var url3 = DownlodClass(title: "Full", subTitle: "For Desktop", url:  "", size: "6MB+",color: .orange)
    //    var url4 = DownlodClass(title: "Raw", subTitle: "Original file", url:  "", size: "10MB+",color: .red)
    
    var body: some View {
        NavigationView {
            List {
                ForEach([url1,url2,url3,url4], id: \.self){ item in
                    DownloadListItem(title: item.title, des: item.subTitle, size: item.size,color: item.color)
                        .onTapGesture {
                            //                            AppFileManager.saveImage(urlString: item.url, fileName: item.title)
                            saveToPhone(imageUrl: item.url)
                            
                        }
                }
            }
            .navigationTitle("Download Image")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .scaledToFit()
                    })
            )
        }
    }
    
    func saveToPhone(imageUrl: String)  {
        let imageServer = ImageSaver()
        var imageData : UIImage!;
        do {
            let imageUrl = try Data(contentsOf: URL(string: imageUrl)!)
            imageData =  UIImage(data: imageUrl)
        } catch {
            print("Error loading image : \(error)")
        }
        
        imageServer.successHandler = {
            print("Its working")
        }
        
        imageServer.errorsHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageServer.writeToPhotoAlbum(image: imageData)
    }
}

//struct DownloadImage_Previews: PreviewProvider {
//    
//        var url1 = DownlodClass(title: "Small", subTitle: "Smallest size", url: "", size: "1MB+",color: .blue)
//        var url2 = DownlodClass(title: "Regular", subTitle: "For mobile wallpaper", url:"", size: "3MB+",color: .yellow)
//        var url3 = DownlodClass(title: "Full", subTitle: "For Desktop", url:  "", size: "6MB+",color: .orange)
//        var url4 = DownlodClass(title: "Raw", subTitle: "Original file", url:  "", size: "10MB+",color: .red)
//    
//    static var previews: some View {
//            DownloadImage()
////        DownloadImage(url1: url1, url2: url1, url3: url1, url4: url1)
//    }
//}
