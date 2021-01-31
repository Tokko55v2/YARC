//
//  OAuthWebViewExtension.swift
//  RedditClient
//
//  Created by Michael Kroneder on 30/01/2021.
//

import OAuthSwift

extension LoginViewModel: OAuthWebViewControllerDelegate {
    func oauthWebViewControllerDidPresent() {}
    func oauthWebViewControllerDidDismiss() {}
    func oauthWebViewControllerWillAppear() {}
    func oauthWebViewControllerDidAppear() {}
    func oauthWebViewControllerWillDisappear() {}
    func oauthWebViewControllerDidDisappear() { oauthswift.cancel() }
}
