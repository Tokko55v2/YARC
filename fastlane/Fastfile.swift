// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    // add actions here: https://docs.fastlane.tools/actions
    func swiftLintLane() {
        desc("Run SwiftLint")
        swiftlint(configFile: ".swiftlint.yml",
                  strict: true,
                  ignoreExitStatus: true,
                  raiseIfSwiftlintError: true,
                  executable: "Pods/SwiftLint/swiftlint")
    }

    func buildLane() {
        desc("Build for testing")
        scan(workspace: "RedditClient.xcworkspace",
             derivedDataPath: "derivedData",
             buildForTesting: true,
             xcargs: "CI=true")
    }
}
