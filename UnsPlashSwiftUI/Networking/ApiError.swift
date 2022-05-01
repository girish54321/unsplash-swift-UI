//
//  ApiError.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 01/05/22.
//

import Foundation
struct ApiError {
    
    private static func CheckApiError(response: HTTPURLResponse?) -> Bool{
        if response?.statusCode == 200 || response?.statusCode == 201 {
            return true;
        } else {
//            guard let errorData = try? JSONDecoder().decode(T.self, from: data! ) else {
//                print("Error: Couldn't decode data into LoginResponseError")
//                return false
//            }
//            return false
            return true
        }
    }
    
    static func checkApiError(response: HTTPURLResponse?) -> Bool{
        return CheckApiError(response: response)
    }
}

