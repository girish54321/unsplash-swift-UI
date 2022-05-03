//
//  HomeScreen.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 01/05/22.
//

import SwiftUI
import Alamofire
import WaterfallGrid

struct HomeScreen: View {
    
    @State var newPhotos: [HomeImage] = []
    @State var pageNumber : Int = 1
    @State var isPageRefreshing : Bool = false
    @State var didAppear = false
    
    @StateObject var homeImageVm = HomeScreenViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                WaterfallGrid(newPhotos) { item in
                    NavigationLink(destination:
                                    SelectedImage(image: SelectedImageClass(id: item.id, createdAt: item.createdAt, updatedAt: item.updatedAt, promotedAt: item.promotedAt, width: item.width, height: item.height, color: item.color, blur_hash: item.blur_hash, homeImageDescription: item.homeImageDescription, altDescription: item.altDescription, description: item.description, urls: item.urls, user: item.user, categories: item.categories))
                    ) {
                        AppNetworkImage(imageUrl: item.urls?.small ?? "")
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
                Button("Load More") {
                    //                    async {
                    //                        homeImageVm.page = homeImageVm.page + 1
                    //                        let images = try? await homeImageVm.getImages(apiParms: nil)
                    //                        withAnimation {
                    //                            newPhotos.append(contentsOf: images ?? [])
                    //                            didAppear = !didAppear
                    //                        }
                    //                    }
                    getHotPhotos(page: pageNumber)
                }
                .padding()
            }
            .onAppear(perform: {
                if !didAppear {
                    getHotPhotos(page: pageNumber)
                }
                didAppear = true
            })
            //            .task {
            //                do {
            //                    let images = try? await homeImageVm.getImages(apiParms: nil)
            //                    withAnimation {
            //                        newPhotos.append(contentsOf: images ?? [])
            //                        didAppear = !didAppear
            //                    }
            //                } catch {
            //                    print("Fetching images failed with error \(error)")
            //                }
            //            }
            .navigationBarTitle("Home", displayMode: .automatic)
            .navigationBarItems(
                trailing:
                    //                Button(action: {
                //
                //                }) {
                //                  Image(systemName: "magnifyingglass")
                //                } //: BUTTON
                NavigationLink(destination:
                                SearchImageScreen()
                              ) {
                                  Image(systemName: "magnifyingglass")
                              }
            )
        }
    }
    
    func getHotPhotos(page:Int) {
        if(newPhotos.isEmpty){
        }
        
        let parameters: [String: Any] = [
            "client_id" : AppConst.clinetid,
            "order_by": "latest",
            "page":String(page),
            "per_page":"20"
        ]
        AF.request(AppConst.baseurl+AppConst.photoUrl,method: .get,parameters: parameters).validate().responseDecodable(of: [HomeImage].self) { (response) in
            guard let data = response.value else {
                isPageRefreshing = false
                return
            }
            withAnimation {
                newPhotos.append(contentsOf: data)
                isPageRefreshing = false
                pageNumber = pageNumber + 1
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
