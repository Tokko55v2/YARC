//
//  EntropyStatus.swift
//  YARC
//
//  Created by Michael Kroneder on 18/04/2021.
//

import Combine
import Foundation

class EntropyStatus {
    let key = "ENTROPY"

    func setEntropyState() {
        if !getEntropyState() {
            UserDefaults.standard.set(true, forKey: key)
        } else {
            UserDefaults.standard.set(false, forKey: key)
        }
    }

    func getEntropyState() -> Bool {
        UserDefaults.standard.bool(forKey: key)
    }
}
