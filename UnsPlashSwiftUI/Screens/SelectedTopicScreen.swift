//File: ContentView.swift
//Project: StretchyHeaderAndParallaxEffect

//Created at 24.11.19 by BLCKBIRDS
//Visit www.BLCKBIRDS.com for more.

import SwiftUI
import NukeUI

struct SelectedTopicScreen: View {
    
    var selectedTopic: TopicResponseElement?
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .global).minY <= 0 {
//                        Image("bg")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: geometry.size.width, height: geometry.size.height)
//                        .offset(y: geometry.frame(in: .global).minY/9)
//                        .clipped()
                        LazyImage(source: selectedTopic?.coverPhoto?.urls?.small ?? "")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(y: geometry.frame(in: .global).minY/9)
                            .clipped()
                    } else {
//                        Image("bg")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
//                            .clipped()
//                            .offset(y: -geometry.frame(in: .global).minY)
                        LazyImage(source: selectedTopic?.coverPhoto?.urls?.small ?? "")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
            }
                .frame(height: 400)
        }
            .edgesIgnoringSafeArea(.top)
            .navigationTitle(selectedTopic?.title ?? "Title")
    }
}

struct SelectedTopicScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectedTopicScreen(selectedTopic: nil)
        }
    }
}

