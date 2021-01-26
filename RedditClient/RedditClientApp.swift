//
//  redditClientApp.swift
//  redditClient
//
//  Created by Michael Kroneder on 22/01/2021.
//
import AppAuth
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var currentAuthorizationFlow: OIDExternalUserAgentSession?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        /*
         Sending the redirection URL to the existing AppAuth flow, if any, for handling the authorization response.
         */
        if let authorizationFlow = currentAuthorizationFlow, authorizationFlow.resumeExternalUserAgentFlow(with: url) {
            currentAuthorizationFlow = nil

            return true
        }

        return false
    }
}

@main
struct RedditClientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
