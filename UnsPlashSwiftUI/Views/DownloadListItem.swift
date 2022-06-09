//
//  DownloadListItem.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 03/05/22.
//

import SwiftUI

struct DownloadListItem: View {
    
    var title: String
    var des: String
    var size: String
    var color: Color
    
    var body: some View {
        HStack(alignment: .center, spacing: 22) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundColor(color)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(des)
                    .font(.caption)
            }
            Spacer()
            Text(size)
                .font(.headline)
                .foregroundColor(color)
        }
        .padding(9)
    }
}

struct DownloadListItem_Previews: PreviewProvider {
    static var previews: some View {
        DownloadListItem(title: "Title", des: "Des", size: "Size", color: .blue)
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
