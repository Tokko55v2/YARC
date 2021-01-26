//
//  redditClientApp.swift
//  redditClient
//
//  Created by Michael Kroneder on 22/01/2021.
//

import SwiftUI

@main
struct RedditClientApp: App {
    init() {
        UITableView.appearance().backgroundColor = .none
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
