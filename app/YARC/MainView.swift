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
    @State var showSubRedditView: Bool = false

    var body: some View {
        TabView(selection: $selection) {
            MainRedditListView(viewModel: MainRedditListViewModel())
                .sheet(isPresented: $showSubRedditView, content: {
                    RedditsView(viewModel: RedditsViewModel())
                })
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                        .font(.system(size: 16, weight: .regular))
                    Text(R.string.localizable.posts_page_title())
                }
                .tag(0)
        }
        .accentColor(Color(R.color.backgroundColorTwo()!))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showSubRedditView: false)
    }
}
