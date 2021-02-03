//
//  ListViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 26/01/2021.
//

import SwiftUI

class SubRedditViewModel: ObservableObject {
    let profileCach = CacheProfile.getProfileCache()
    @Published var profile = Profile()

    init() {}

    func refresh() {
        guard let profile = profileCach.get(key: "firstUser") else {
            return
        }
        self.profile = profile
    }
}
