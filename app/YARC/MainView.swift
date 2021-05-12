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

            Text("WIP: Profil")
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 16, weight: .regular))
                    Text(R.string.localizable.profile_page_title())
                }
                .tag(1)

            Text("WIP: Settings")
                .tabItem {
                    Image(systemName: "gear")
                        .font(.system(size: 16, weight: .regular))
                    Text(R.string.localizable.settings_page_title())
                }
                .tag(2)
        }
        .accentColor(Color(R.color.backgroundColorTwo()!))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showSubRedditView: false)
    }
}
