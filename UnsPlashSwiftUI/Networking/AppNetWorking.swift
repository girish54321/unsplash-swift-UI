//
//  AppNetWorking.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 02/05/22.
//

import Foundation
import Alamofire

class HomeScreenViewModel : ObservableObject {
    
    //MARK: - Properties
    var homeImages : [HomeImage] = []
    
    var totalPages = 10
    var page : Int = 1
    
    init() {
        getHomeScreenImages(apiParms: nil)
    }
    
    //MARK: - PAGINATION
    func loadMoreContent(currentItem item: HomeImage){
        //        let thresholdIndex = self.homeImages.index(self.homeImages.endIndex, offsetBy: -1)
        //        if thresholdIndex == Int(item.id!), (page + 1) <= totalPages {
        //            page += 1
        //            getHomeScreenImages(apiParms: nil)
        //        }
        if(homeImages.count > 1 && item.id == homeImages[homeImages.endIndex - 1].id){
            page += 1
            getHomeScreenImages(apiParms: nil)
        }
    }
    
    //MARK: - API CALL
    func getHomeScreenImages(apiParms: Parameters?) {
        var parms: Parameters = [:]
        if apiParms == nil {
            parms  = [
                "client_id" : AppConst.clinetid,
                "order_by": "latest",
                "page":String(page),
                "per_page":"20"
            ]
        } else {
            parms = apiParms!
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(AppConst.baseurl+AppConst.photoUrl,method: .get,parameters: parms).validate().responseDecodable(of: [HomeImage].self) { [weak self] (response) in
            switch response.result{
            case .success(let data):
                self?.homeImages.append(contentsOf: data)
            case .failure(let afError):
                print("Error : \(afError)")
                //Handle error
            }
        }
    }
    
    func getImages(apiParms: Parameters?) async throws -> [HomeImage] {
        var parms: Parameters = [:]
        if apiParms == nil {
            parms  = [
                "client_id" : AppConst.clinetid,
                "order_by": "latest",
                "page":String(page),
                "per_page":"20"
            ]
        } else {
            parms = apiParms!
        }
        
        AF.request(AppConst.baseurl+AppConst.photoUrl,method: .get,parameters: parms).validate().responseDecodable(of: [HomeImage].self) { [weak self] (response) in
            switch response.result{
            case .success(let data):
                self?.homeImages.append(contentsOf: data)
            case .failure(let afError):
                print("Error : \(afError)")
            }
        }
        return self.homeImages
    }
}
