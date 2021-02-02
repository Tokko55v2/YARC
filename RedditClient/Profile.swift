//
//  Profile.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//

import Foundation

class Profile: ObservableObject {
    var id: UUID
    var subReddit: [ProfileSubReddit]

    init(_ subReddit: [ProfileSubReddit]) {
        self.subReddit = subReddit
        id = UUID()
    }
}

extension Profile {
    func contain(uuid: UUID) -> Bool {
        id == uuid
    }
}

extension Profile: Hashable {
    // swiftlint:disable operator_whitespace
    static func ==(lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class ProfileSubReddit {
    var subscribers: Int64
    var displayName: String
    var title: String
    var displayNamePrefixed: String
    var subredditType: String
    var over18: Bool

    init(subscribers: Int64, displayName: String, title: String, displayNamePrefixed: String, subredditType: String, over18: Bool) {
        self.subscribers = subscribers
        self.displayName = displayName
        self.title = title
        self.displayNamePrefixed = displayNamePrefixed
        self.subredditType = subredditType
        self.over18 = over18
    }
}

extension ProfileSubReddit {
    static func mapSubRedditToProfilSubReddit(subReddit: SubReddit) -> ProfileSubReddit {
        ProfileSubReddit(subscribers: subReddit.subscribers,
                         displayName: subReddit.display_name,
                         title: subReddit.title,
                         displayNamePrefixed: subReddit.display_name_prefixed,
                         subredditType: subReddit.subreddit_type,
                         over18: subReddit.over18)
    }
}
