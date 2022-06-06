//
//  SelectedImage.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 02/05/22.
//

import SwiftUI
import BottomSheetSwiftUI
import NukeUI
import Nuke
import AlertToast

struct SelectedImage: View {
    
    var image: SelectedImageClass?
    @State private var isShowingDownloadView: Bool = false
    @StateObject private var myImage = FetchImage()
    
    @State private var isSharePresented: Bool = false
    @State var isLocalImage: Bool?
    @State var localImageURL: URL?
    @EnvironmentObject var viewModel: AlertViewModel
    var body: some View {
        ZStack {
            if isLocalImage == true {
                AppNetworkImage(imageUrl:"\(localImageURL!)")
            } else {
                AppNetworkImage(imageUrl: image?.urls?.small ?? "" )
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if !(isLocalImage ?? false)  {
                        Button(action: {
                            isShowingDownloadView.toggle()
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
                        .sheet(isPresented: $isShowingDownloadView) {
                            let url1 = DownlodClass(title: "Small", subTitle: "Smallest size", url: image?.urls?.small ?? "", size: "1MB+",color: .blue)
                            let url2 = DownlodClass(title: "Regular", subTitle: "For mobile wallpaper", url:image?.urls?.regular ?? "", size: "3MB+",color: .yellow)
                            let url3 = DownlodClass(title: "Full", subTitle: "For Desktop", url:  image?.urls?.full ?? "", size: "6MB+",color: .orange)
                            let url4 = DownlodClass(title: "Raw", subTitle: "Original file", url:  image?.urls?.raw ?? "", size: "10MB+",color: .red)
                            DownloadImage(url1: url1, url2: url2, url3: url3, url4: url4)
                        }
                    } else {
                        Text("")
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
        .navigationBarTitle(Text(image?.description ?? "Image Viewer"),displayMode: .inline)
        .navigationBarItems(
            trailing:
                VStack {
                    if isLocalImage == true {
                        Button(action: {
                            saveToImageApp()
                        }, label: {
                            Image(systemName: "sdcard.fill")
                                .scaledToFit()
                        })
                    } else {
                        Text("")
                    }
                }
        )
    }
    
    func saveToImageApp() {
        var imageData : UIImage!;
        do {
            let imageUrl = try Data(contentsOf: localImageURL!)
            imageData =  UIImage(data: imageUrl)
        } catch {
            print("Error loading image : \(error)")
        }
        let imageSever = ImageSaver()
        
        imageSever.successHandler = {
            print("Go For It")
            viewModel.alertToast = AlertToast(
                displayMode: .banner(.pop),
                type: .error(.blue),
                title: "Image Saved",
                subTitle: "Image is saved on your Camera Roll")
        }
        imageSever.errorsHandler = {
            print("\($0.localizedDescription)")
        }
        imageSever.writeToPhotoAlbum(image: imageData)
    }
}

struct SelectedImage_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SelectedImage()
        }
    }
}
