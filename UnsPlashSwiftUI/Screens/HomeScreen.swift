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
    @State var pageNumber : Int = 0
    @State var isPageRefreshing : Bool = false
    @State var didAppear = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                  WaterfallGrid(newPhotos) { item in
                      AppNetworkImage(imageUrl: item.urls?.small ?? "")
                  }
                  .gridStyle(
                    columnsInPortrait: 2,
                    columnsInLandscape: 3,
                    spacing: 8,
                    animation: .easeInOut(duration: 0.5)
                  )
                  .scrollOptions(direction: .vertical)
                  .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                }
                .onAppear(perform: {
                    if !didAppear {
                        getHotPhotos(page: pageNumber)
                    }
                    didAppear = true
                })
            }
            .navigationBarTitle("Home", displayMode: .automatic)
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
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
