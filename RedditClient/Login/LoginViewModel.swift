//
//  LoginViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import Foundation
import OAuthSwift
import UIKit
import WebKit

class LoginViewModel: ObservableObject {
    let oauthswift = OAuth2Swift(consumerKey: "",
                                 consumerSecret: "",
                                 authorizeUrl: "https://www.reddit.com/api/v1/authorize.compact",
                                 accessTokenUrl: "https://www.reddit.com/api/v1/access_token",
                                 responseType: "code",
                                 contentType: "application/json")

    lazy var internalWebViewController: WKWebViewController = {
        let controller = WKWebViewController()
        controller.view = UIView(frame: UIScreen.main.bounds)
        controller.loadView()
        controller.viewDidLoad()
        return controller
    }()

    func doOauthReddit() {
        oauthswift.accessTokenBasicAuthentification = true
        oauthswift.authorizeURLHandler = internalWebViewController
        let state = generateState(withLength: 20)

        _ = oauthswift.authorize(withCallbackURL: URL(string: "oauth-swift://oauth-callback/reddit")!, scope: "read", state: state) { result in
            switch result {
            case let .success((credential, _, _)):
                print("\(credential)")
            case let .failure(error):
                print(error.description)
            }
        }
    }
}
