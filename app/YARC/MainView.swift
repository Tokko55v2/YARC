//
//  MainTabView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//
import CoreData
import SwiftUI

struct MainView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            MainRedditListView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                        .font(.system(size: 16, weight: .regular))
                    Text(R.string.localizable.posts_page_title())
                }
                .tag(0)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
