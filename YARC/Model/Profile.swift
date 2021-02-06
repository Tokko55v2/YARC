//
//  Profile.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//
import Foundation
class Profile: ObservableObject {
    var id: UUID
    var subReddit: [ProfileSubReddit]?

    init(_ subReddit: [ProfileSubReddit]) {
        self.subReddit = subReddit
        id = UUID()
    }

    init() {
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

class ProfileSubReddit: Identifiable {
    var subscribers: Int64
    var displayName: String
    var title: String
    var displayNamePrefixed: String
    var subredditType: String
    var over18: Bool
    var primaryColor: String
    var iconImg: String
    var publicDescription: String
    var bannerBackgroundColor: String
    var url: String

    init(subscribers: Int64,
         displayName: String,
         title: String,
         displayNamePrefixed: String,
         subredditType: String,
         over18: Bool,
         primaryColor: String,
         iconImg: String,
         publicDescription: String,
         bannerBackgroundColor: String,
         url: String) {
        self.subscribers = subscribers
        self.displayName = displayName
        self.title = title
        self.displayNamePrefixed = displayNamePrefixed
        self.subredditType = subredditType
        self.over18 = over18
        self.primaryColor = primaryColor
        self.iconImg = iconImg
        self.publicDescription = publicDescription
        self.bannerBackgroundColor = bannerBackgroundColor
        self.url = url
    }
}

extension ProfileSubReddit {
    static func mapSubRedditToProfilSubReddit(subReddit: SubReddit) -> ProfileSubReddit {
        ProfileSubReddit(subscribers: subReddit.subscribers,
                         displayName: subReddit.display_name,
                         title: subReddit.title,
                         displayNamePrefixed: subReddit.display_name_prefixed,
                         subredditType: subReddit.subreddit_type,
                         over18: subReddit.over18,
                         primaryColor: subReddit.primary_color,
                         iconImg: subReddit.icon_img,
                         publicDescription: subReddit.public_description,
                         bannerBackgroundColor: subReddit.banner_background_color,
                         url: subReddit.url)
    }
}
