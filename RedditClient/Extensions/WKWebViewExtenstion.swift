//
//  WKWebViewExtenstion.swift
//  RedditClient
//
//  Created by Michael Kroneder on 30/01/2021.
//

import OAuthSwift
import UIKit
import WebKit

extension WKWebViewController: WKUIDelegate, WKNavigationDelegate {
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded")
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // Check for OAuth Callback
        if let url = navigationAction.request.url, url.scheme == "oauthkeychainapp" {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            dismiss(animated: true, completion: nil)
            decisionHandler(.cancel)
            return
        }

        // Restrict URL's a user can access
        if let host = navigationAction.request.url?.host {
            if host.contains("reddit") {
                decisionHandler(.allow)
                return
            } else {
                // open link outside of our app
                UIApplication.shared.open(navigationAction.request.url!)
                decisionHandler(.cancel)
                return
            }
        }

        decisionHandler(.cancel)
    }
}
