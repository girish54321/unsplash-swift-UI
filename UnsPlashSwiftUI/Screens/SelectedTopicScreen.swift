import SwiftUI
import NukeUI
import Alamofire
import WaterfallGrid

struct SelectedTopicScreen: View {
    
    var selectedTopic: TopicResponseElement?
    
    @State var newPhotos: [HomeImage] = []
    @State var pageNumber : Int = 1
    @State var isPageRefreshing : Bool = false
    @State var didAppear = false
    
    @EnvironmentObject var appStateStorage: AppStateStorage
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .global).minY <= 0 {
                        LazyImage(source: selectedTopic?.coverPhoto?.urls?.small ?? "")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(y: geometry.frame(in: .global).minY/9)
                            .clipped()
                    } else {
                        LazyImage(source: selectedTopic?.coverPhoto?.urls?.small ?? "")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
            }
            .frame(height: 340)
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
            if isPageRefreshing == true {
                Text("")
            } else {
                Button("Load More") {
                    getPhotos(page: pageNumber)
                }
                .padding()
            }
        }
        .onAppear(perform: {
            if !didAppear {
                getPhotos(page: pageNumber)
            }
            didAppear = true
        })
        .edgesIgnoringSafeArea(.top)
        .navigationTitle(selectedTopic?.title ?? "Title")
        .navigationBarItems(
            trailing:
                NavigationLink(destination:
                                SearchImageScreen()
                              ) {
                                  Image(systemName: "magnifyingglass")
                              }
        )
    }
    
    func getPhotos(page:Int) {
        isPageRefreshing = true
        appStateStorage.toogleLoading()
        let parameters: [String: Any] = [
            "client_id" : AppConst.clinetid,
            "page":String(page),
            "per_page":"20"
        ]
        AF.request(AppConst.baseurl+AppConst.topics+(selectedTopic?.id ?? "")+"/photos",method: .get,parameters: parameters).validate().responseDecodable(of:[HomeImage].self) { (response) in
            guard let data = response.value else {
                print("api error")
                isPageRefreshing = false
                return
            }
            withAnimation {
                newPhotos.append(contentsOf: data)
                isPageRefreshing = false
                pageNumber = pageNumber + 1
            }
            appStateStorage.toogleLoading()
        }
    }
}

struct SelectedTopicScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectedTopicScreen(selectedTopic: nil)
        }
    }
}

