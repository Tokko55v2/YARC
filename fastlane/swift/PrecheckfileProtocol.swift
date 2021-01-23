// PrecheckfileProtocol.swift
// Copyright (c) 2021 FastlaneTools

public protocol PrecheckfileProtocol: AnyObject {
    /// Path to your App Store Connect API Key JSON file (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-json-file)
    var apiKeyPath: String? { get }

    /// Your App Store Connect API Key information (https://docs.fastlane.tools/app-store-connect-api/#use-return-value-and-pass-in-as-an-option)
    var apiKey: [String: Any]? { get }

    /// The bundle identifier of your app
    var appIdentifier: String { get }

    /// Your Apple ID Username
    var username: String { get }

    /// The ID of your App Store Connect team if you're in multiple teams
    var teamId: String? { get }

    /// The name of your App Store Connect team if you're in multiple teams
    var teamName: String? { get }

    /// The platform to use (optional)
    var platform: String { get }

    /// The default rule level unless otherwise configured
    var defaultRuleLevel: String { get }

    /// Should check in-app purchases?
    var includeInAppPurchases: Bool { get }

    /// Should force check live app?
    var useLive: Bool { get }

    /// using text indicating that your IAP is free
    var freeStuffInIap: String? { get }
}

extension PrecheckfileProtocol {
    public var apiKeyPath: String? { nil }
    public var apiKey: [String: Any]? { nil }
    public var appIdentifier: String { "" }
    public var username: String { "" }
    public var teamId: String? { nil }
    public var teamName: String? { nil }
    public var platform: String { "ios" }
    public var defaultRuleLevel: String { "error" }
    public var includeInAppPurchases: Bool { true }
    public var useLive: Bool { false }
    public var freeStuffInIap: String? { nil }
}

// Please don't remove the lines below
// They are used to detect outdated files
// FastlaneRunnerAPIVersion [0.9.51]
