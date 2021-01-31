//
//  MainTabView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ListMainView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                        .font(.system(size: 16, weight: .regular))
                    Text("Posts")
                }

            Text("WIP: Profil")
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 16, weight: .regular))
                    Text("Profil")
                }

            Text("WIP: Settings")
                .tabItem {
                    Image(systemName: "gear")
                        .font(.system(size: 16, weight: .regular))
                    Text("Settings")
                }
        }
        .accentColor(Color(R.color.backgroundColorTwo()!))
    }
}
