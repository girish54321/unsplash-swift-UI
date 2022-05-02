//
//  Users.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 02/05/22.
//

import Foundation

struct UserListResponseData : Codable, Identifiable, Hashable{
    let id : Int?
    let email : String?
    var first_name : String?
    let last_name : String?
    let avatar : String?
}

struct UserListResponse : Codable {
    let page : Int?
    let per_page : Int?
    let total : Int?
    let total_pages : Int?
    var data : [UserListResponseData]?
    let support : Support?
}

struct Support : Codable{
    let url : String?
    let text : String?
}
