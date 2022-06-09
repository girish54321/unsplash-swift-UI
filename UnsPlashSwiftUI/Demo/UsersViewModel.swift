//
//  UsersViewModel.swift
//  Pagination
//
//  Created by Apoorv Garg on 17/04/21.
//

import Foundation
import Alamofire

class UsersViewModel : ObservableObject {
    
    //MARK: - Properties
    @Published var users : [UserListResponseData] = []
    
    var totalPages = 0
    var page : Int = 1
    
    init() {
        getUsers()
    }
    
    //MARK: - PAGINATION
    func loadMoreContent(currentItem item: UserListResponseData){
        let thresholdIndex = self.users.index(self.users.endIndex, offsetBy: -1)
        if thresholdIndex == Int(item.id!), (page + 1) <= totalPages {
            page += 1
            getUsers()
        }
    }
    
    //MARK: - API CALL
    func getUsers(){
        
        let apiUrl = "https://reqres.in/api/users?page=\(page)"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(apiUrl).responseDecodable(of: UserListResponse.self, decoder: decoder) { [weak self] (response) in
            switch response.result{
                case .success(let users):
                self?.totalPages = users.total_pages ?? 0
                self?.users.append(contentsOf: users.data ?? [])
                case .failure(let afError):
                    print("Error : \(afError)")
                //Handle error
            }
        }
    }
    
}
