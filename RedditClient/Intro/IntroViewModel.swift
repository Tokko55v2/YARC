//
//  IntroViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//

import Alamofire
import Combine
import SwiftUI

class IntroViewModel: ObservableObject {
    private var dataService: DataService?
    let profileCach = CacheProfile.getProfileCache()
    @Published var subReddit: SubReddits

    init() {
        dataService = DataService()
        subReddit = SubReddits()
        fetchSubReddits()
    }

    func fetchSubReddits() {
        dataService?.requestSubReddits(completion: { data, error in
            if let error = error {
                print("\(error)")
                return
            }
            if let data = data {
                self.subReddit = data
            }
        })
    }

    func cacheProfile(_ profile: Set<SubReddit>) {
        var temp = [ProfileSubReddit]()
        for subReddit in profile {
            temp.append(ProfileSubReddit.mapSubRedditToProfilSubReddit(subReddit: subReddit))
        }
        let profile = Profile(temp)
        profileCach.set(key: "firstUser", profile: profile)
    }
}
