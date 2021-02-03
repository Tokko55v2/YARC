//
//  ProfileCache.swift
//  RedditClient
//
//  Created by Michael Kroneder on 02/02/2021.
//

import Foundation

class CacheProfile {
    var profile = NSCache<NSString, Profile>()

    func get(key: NSString) -> Profile? {
        profile.object(forKey: key)
    }

    func set(key: NSString, profile: Profile) {
        self.profile.setObject(profile, forKey: key)
    }
}

extension CacheProfile {
    static var cacheProfile = CacheProfile()
    static func getProfileCache() -> CacheProfile {
        cacheProfile
    }
}
