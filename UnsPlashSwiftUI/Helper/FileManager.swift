//
//  FileManager.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 21/05/22.
//

import Foundation
import UIKit
import SwiftUI

struct AppFileManager {
    static func saveImage(urlString:String, fileName:String) {
        
        @Binding var showAlart : Bool
        
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "\(UUID().uuidString).png"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("successfully saved!")
//                vc.view.removeBluerLoader()
//                UIHelper.loadLocalImages()
//                Alert.showDonlodDoneAlert(on: vc)
            } catch {
                print("could not be saved")
            }
        }
    }
}

struct ActivityViewController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}
