//
//  LoginViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import AppAuth
import Foundation
import UIKit

class LoginViewModel: UIViewController {
    /**
     OAuth 2 client ID.

     Dynamic client registration is not demonstrated in this example.
     */
    let clientId = "<client-id>"

    /**
     Scheme used in the redirection URI.

     This value is provided separately so that its presence in `Info.plist` can be easily checked and so that it can be reused with different redirection URIs.
     */
    let redirectionUriScheme = "com.myapp"

    /**
     OAuth 2 redirection URI for the client.

     The redirection URI is provided as a computed property, so that it can refer to the class' instance properties.
     */
    var redirectionUri: String {
        redirectionUriScheme + "://oauth2redirect/reddit"
    }

    /**
     Class property to store the authorization state.
     */
    var authState: OIDAuthState?

    /**
     The key under which the authorization state will be saved in a keyed archive.
     */
    let authStateKey = "authState"

    /**
     OpenID Connect issuer URL, where the OpenID configuration can be obtained from.
     */
    let issuerUrl: String = "https://oauth.reddit.com/api/v1/me"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        loadState()

        showState()

        if authState == nil {
            authorizeRp(issuerUrl: issuerUrl, configuration: nil)
        }
    }

    /**
     Makes token exchange request.

     The code obtained from the authorization request is exchanged at the token endpoint.
     */
    func makeTokenRequest(completion: @escaping (OIDAuthState?, Error?) -> Void) {
        guard let tokenExchangeRequest = authState?.lastAuthorizationResponse.tokenExchangeRequest() else {
            print("Error creating access token request.")

            return
        }

        print("Making token request with: ", tokenExchangeRequest)

        OIDAuthorizationService.perform(tokenExchangeRequest) { response, error in

            if let response = response {
                print("Received token response with access token: ", response.accessToken ?? "")
            } else {
                print("Error making token request: \(error?.localizedDescription ?? "")")
            }

            self.authState?.update(with: response, error: error)

            completion(self.authState, error)
        }
    }

    /**
     Performs the authorization code flow in two steps.

     Attempts to perform a request to authorization endpoint by utilizing an OIDAuthorizationService method.
     Completes authorization code flow with code exchange initiated manually by invoking a separate OIDAuthorizationService method.
     The response is then passed to the completion handler, which lets the caller to handle the results.

     This method is not used and is here for illustration purposes.
     */
    func authorizeWithManualCodeExchange(configuration: OIDServiceConfiguration,
                                         clientId: String,
                                         redirectionUri: String,
                                         scopes: [String] = [OIDScopeOpenID, OIDScopeProfile],
                                         completion: @escaping (OIDAuthState?, Error?) -> Void) {
        // Checking if the redirection URL can be constructed.
        guard let redirectURI = URL(string: redirectionUri) else {
            print("Error creating redirection URL for : \(redirectionUri)")

            return
        }

        // Checking if the AppDelegate property holding the authorization session could be accessed.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error accessing AppDelegate")

            return
        }

        // Building authorization request.
        let request = OIDAuthorizationRequest(configuration: configuration,
                                              clientId: clientId,
                                              clientSecret: nil,
                                              scopes: scopes,
                                              redirectURL: redirectURI,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: nil)

        // Making authorization request.
        appDelegate.currentAuthorizationFlow = OIDAuthorizationService.present(request, presenting: self) { response, error in

            if let response = response {
                print("Received authorization response with code: \(response.authorizationCode ?? "")")

                let authState = OIDAuthState(authorizationResponse: response)

                self.setAuthState(authState)
                // Custom processing here.

                self.makeTokenRequest { authState, error in

                    completion(authState, error)
                }
            } else {
                print("Error making authorization request: \(error?.localizedDescription ?? "")")

                completion(nil, error)
            }
        }
    }
}
