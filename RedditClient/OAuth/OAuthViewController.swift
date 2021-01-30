//
//  OAuthViewController.swift
//  RedditClient
//
//  Created by Michael Kroneder on 30/01/2021.
//
import OAuthSwift
import UIKit
import WebKit

class OAuthController: OAuthViewController {
    let oauthswift = OAuth2Swift(consumerKey: "xxxxxx",
                                 consumerSecret: "xxxxxx",
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        doOauthReddit()
    }

    fileprivate func doOauthReddit() {
        oauthswift.authorizeURLHandler = internalWebViewController

        // guard let callbackURL = URL(string: "oauthkeychainapp://oauthkeychain-callback") else { return }

        let state = generateState(withLength: 20)

        _ = oauthswift.authorize(withCallbackURL: URL(string: "oauth-swift://oauth-callback/reddit")!, scope: "read", state: state) { [self] result in
            switch result {
            case let .success((credential, _, _)):
                print("\(credential)")
                self.testReddit(self.oauthswift, credential.oauthToken)
            case let .failure(error):
                print(error.description)
            }
        }
    }

    func testReddit(_ oauthswift: OAuth2Swift, _ oauthToken: String) {
        let applicationName = "" // Provided by developer
        let username = "" // Provided by developer
        let userAgent = "ios:\(applicationName):1.0 (by /u/\(username)"
        let headers = ["Authorization": "Bearer \(oauthToken)", "User-Agent": userAgent]
        _ = oauthswift.client.get("https://oauth.reddit.com/r/all", headers: headers) { result in
            switch result {
            case let .success(response):
                let dataString = response.string!
                print(dataString)
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension OAuthController: OAuthWebViewControllerDelegate {
    func oauthWebViewControllerDidPresent() {}
    func oauthWebViewControllerDidDismiss() {}
    func oauthWebViewControllerWillAppear() {}
    func oauthWebViewControllerDidAppear() {}
    func oauthWebViewControllerWillDisappear() {}
    func oauthWebViewControllerDidDisappear() { oauthswift.cancel() }
}
