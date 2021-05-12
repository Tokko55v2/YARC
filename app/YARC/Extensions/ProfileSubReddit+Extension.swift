//
//  ProfileSubReddit+Extension.swift
//  YARC
//
//  Created by Michael Kroneder on 18/04/2021.
//

import Foundation
import YARC_SDK

extension ProfilsReddit {
    static func mapSubRedditToProfilSubReddit(subReddit: SubReddit) -> ProfilsReddit {
        ProfilsReddit(subscribers: subReddit.subscribers,
                      displayName: subReddit.display_name,
                      title: subReddit.title,
                      displayNamePrefixed: subReddit.display_name_prefixed,
                      subredditType: subReddit.subreddit_type,
                      over18: subReddit.over18,
                      primaryColor: subReddit.primary_color,
                      iconImg: subReddit.icon_img,
                      publicDescription: subReddit.public_description,
                      bannerBbackgroundCcolor: subReddit.banner_background_color,
                      url: subReddit.url)
    }
}
