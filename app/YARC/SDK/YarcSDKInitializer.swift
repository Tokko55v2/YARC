//
//  File.swift
//  YARC
//
//  Created by Michael Kroneder on 14/04/2021.
//

import Foundation
import YARC_SDK

// swiftlint:disable superfluous_disable_command
// swiftlint:disable type_name
class YARCSDK {
    private static var instance: YARCSDK?
    // swiftlint:disable computed_accessors_order
    public private(set) static var shared: YARCSDK {
        set {
            instance = newValue
        }
        get {
            guard let instance = instance else {
                fatalError("\(String(describing: Self.self))")
            }
            return instance
        }
    }

    public private(set) var module: YarcModule!

    private init() {}

    public static func initShared() {
        Self.shared = YARCSDK()
        YARCSDK.shared.module = YarcModuleBuilder().build()
    }
}
