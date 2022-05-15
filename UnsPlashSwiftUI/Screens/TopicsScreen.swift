//
//  TopicsScreen.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 15/05/22.
//

import SwiftUI
import Alamofire
import WaterfallGrid

struct TopicsScreen: View {
    
    @State var topicsData : [TopicResponseElement] = []
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    WaterfallGrid(topicsData) { item in
                        NavigationLink(destination:
                                        SelectedImage(image: SelectedImageClass(id: item.id, createdAt: nil, updatedAt: item.updatedAt, promotedAt: item.promotedAt, width: item.width, height: item.height, color: item.color, blur_hash: item.blur_hash, homeImageDescription: item.homeImageDescription, altDescription: item.altDescription, description: item.description, urls: item.urls, user: item.user, categories: item.categories))
                        ) {
                            AppNetworkImage(imageUrl: item.coverPhoto?.urls?.regular ?? "")
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
                }
                Button("Load More") {
                    getTopicsPhotos()
                }
                .padding()
            }
            .onAppear(perform: {
                if !didAppear {
                    getHomePhotos(page: pageNumber)
                }
                didAppear = true
            })
            .navigationBarTitle("Home", displayMode: .automatic)
            .navigationBarItems(
                trailing:
                    NavigationLink(destination:
                                    SearchImageScreen()
                                  ) {
                                      Image(systemName: "magnifyingglass")
                                  }
            )
        }
    }
    
    func getTopicsPhotos() {
        let parameters: [String: Any] = [
            "client_id" : AppConst.clinetid,
            "per_page" : 50
        ]
        AF.request(AppConst.baseurl+AppConst.topics,method: .get,parameters: parameters).validate().responseDecodable(of: [TopicResponseElement].self) { (response) in
            guard let data = response.value else {
                print("Topic Error")
                return
            }
//            topicsData.append(contentsOf: data)
            topicsData.append(contentsOf: data)
        }
    }
}

struct TopicsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TopicsScreen()
    }
}
