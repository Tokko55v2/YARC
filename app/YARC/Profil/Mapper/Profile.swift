//
//  Profile.swift
//  YARC
//
//  Created by Michael Kroneder on 14/04/2021.
//
import Foundation
import YARC_SDK

class Profile {
    var id = UUID()
    var subReddit: [ProfilsReddit]?
}

struct ProfilsReddit {
    var subscribers: Int64
    var displayName: String
    var title: String
    var displayNamePrefixed: String
    var subredditType: String
    var over18: Bool
    var primaryColor: String
    var iconImg: String
    var publicDescription: String
    var bannerBbackgroundCcolor: String
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
         bannerBbackgroundCcolor: String,
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
        self.bannerBbackgroundCcolor = bannerBbackgroundCcolor
        self.url = url
    }
}
