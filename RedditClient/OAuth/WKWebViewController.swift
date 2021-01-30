import OAuthSwift
import UIKit
import WebKit

class WKWebViewController: OAuthWebViewController {
    var webView: WKWebView!
    var targetURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func handle(_ url: URL) {
        targetURL = url
        super.handle(url)
        loadAddressURL()
    }

    func loadAddressURL() {
        guard let url = targetURL else { return }
        let req = URLRequest(url: url)

        webView?.load(req)
    }
}
