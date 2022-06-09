//
//  UiHelper.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 01/05/22.
//

import Foundation
import SwiftUI

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
    }
    
    func inputIconStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
    }
}
