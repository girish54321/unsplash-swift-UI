//
//  SavedImagesScreen.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 21/05/22.
//

import SwiftUI
import UIKit
import NukeUI
import WaterfallGrid
import Nuke

struct SavedImagesScreen: View {
    
    @State var savedImages :[URL] = []
    
    let fileManager = FileManager.default
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    @StateObject private var image = FetchImage()
    var body: some View {
        NavigationView {
            ScrollView {
                WaterfallGrid(savedImages,id: \.self) { item in
                    NavigationLink(destination:
                                    SelectedImage(isLocalImage: true, localImageURL: item)
                    ) {
                        AppNetworkImage(imageUrl: "\(item)" )
                    }
                }
                .gridStyle(
                    columnsInPortrait: 2,
                    columnsInLandscape: 3,
                    spacing: 8,
                    animation: .linear(duration: 0.5)
                )
                .scrollOptions(direction: .vertical)
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .onAppear{
                    loadSavedImages()
                }
            }
            .navigationTitle("Saved Images")
        }
    }
    
    func loadSavedImages(){
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            savedImages.removeAll()
            savedImages = directoryContents
            print(directoryContents[0])
        } catch {
            print(error)
        }
    }
}

struct SavedImagesScreen_Previews: PreviewProvider {
    static var previews: some View {
        SavedImagesScreen()
    }
}
