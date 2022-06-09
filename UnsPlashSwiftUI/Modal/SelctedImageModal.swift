//
//  SelctedImageModal.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 02/05/22.
//

import Foundation

struct SelectedImageClass: Decodable, Identifiable {
    var id: String?
    var createdAt, updatedAt, promotedAt: Date?
    var width, height: Int?
    var color, blur_hash, homeImageDescription, altDescription, description: String?
    var urls: Urls?
    var user: User?
    var categories: [String]?
}


