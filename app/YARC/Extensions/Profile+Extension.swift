//
//  Profile+Extension.swift
//  YARC
//
//  Created by Michael Kroneder on 18/04/2021.
//

import Foundation

extension Profile {
    func contain(uuid: UUID) -> Bool {
        id == uuid
    }
}

// swiftlint:disable operator_whitespace
extension Profile: Hashable {
    static func ==(lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
