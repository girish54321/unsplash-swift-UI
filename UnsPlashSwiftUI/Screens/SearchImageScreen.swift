//
//  SearchImageScreen.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 03/05/22.
//

import SwiftUI
import Alamofire
import WaterfallGrid

let screenTitle : String = "Search Your Image.."

struct SearchImageScreen: View {
    
    @EnvironmentObject var appStateStorage: AppStateStorage
    @State private var searchText = ""
    @State var newPhotos:[Result] = []
    @State var pageNumber : Int = 1
    
    @State var isPageRefreshing : Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                WaterfallGrid(newPhotos) { item in
                    NavigationLink(destination:
                                    SelectedImage(image: SelectedImageClass(id: item.id, createdAt: item.createdAt, updatedAt: item.updatedAt, promotedAt: item.promotedAt, width: item.width, height: item.height, color: item.color, blur_hash: item.blur_hash, homeImageDescription: "", altDescription: item.altDescription, description: "", urls: item.urls, user: item.user, categories: item.categories))
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
                if newPhotos.count > 0  {
                    Button("Load More") {
                        getSearchPhotos(page: pageNumber)
                    }
                    .padding()
                } else {
                    Text("")
                }
                if newPhotos.count == 0 {
                    VStack {
                        Image("search")
                            .imageModifier()
                            .transition(.opacity)
                        Text(screenTitle)
                            .font(.title2)
                    }
                } else {
                    Text("")
                }
            }
        }
        .navigationTitle(screenTitle)
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            if newValue == "" {
                withAnimation {
                    newPhotos.removeAll()
                }
            }
        }
        .onSubmit(of: .search) {
            getSearchPhotos(page: pageNumber)
        }
    }
    
    func getSearchPhotos(page:Int) {
        appStateStorage.toogleLoading()
        isPageRefreshing = true
        let parameters: [String: Any] = [
            "client_id" : AppConst.clinetid,
            "query": searchText,
            "page": String(page),
            "per_page": "30"
        ]
        AF.request(AppConst.baseurl+AppConst.search,method: .get,parameters: parameters).validate().responseDecodable(of: SearchImageResponse.self) { (response) in
            print(response)
            guard let data = response.value else {
                isPageRefreshing = true
                return
            }
            appStateStorage.toogleLoading()
            withAnimation {
                isPageRefreshing = true
                self.newPhotos.append(contentsOf: data.results!)
                pageNumber = pageNumber + 1
            }
        }
    }
}

struct SearchImageScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchImageScreen()
        }
    }
}
