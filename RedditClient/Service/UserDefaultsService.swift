//
//  UserDefaultsService.swift
//  RedditClient
//
//  Created by Michael Kroneder on 05/02/2021.
//

import Combine
import Foundation

class UserDefaultsService: ObservableObject {
    var defaults = UserDefaults()

    @Published var entropy: Bool {
        didSet {
            UserDefaults.standard.set(entropy, forKey: ClientConstants.ENTROPY)
        }
    }

    @Published var initialProfileStatus: Bool = false {
        didSet {
            UserDefaults.standard.set(initialProfileStatus, forKey: ClientConstants.PROFILE)
        }
    }

    init() {
        entropy = UserDefaults.standard.bool(forKey: ClientConstants.ENTROPY)
        initialProfileStatus = UserDefaults.standard.bool(forKey: ClientConstants.PROFILE)
    }

    func getEntropy() -> Bool {
        UserDefaults.standard.bool(forKey: ClientConstants.ENTROPY)
    }
}
