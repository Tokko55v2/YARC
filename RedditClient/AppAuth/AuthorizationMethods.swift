//
//  AuthorizationMethods.swift
//  RedditClient
//
//  Created by Michael Kroneder on 24/01/2021.
//

import AppAuth
import Foundation

extension LoginViewModel {
    /**
     Authorizes the Relying Party with an OIDC Provider.

     - Parameter issuerUrl: The OP's `issuer` URL to use for OpenID configuration discovery
     - Parameter configuration: Ready to go OIDServiceConfiguration object populated with the OP's endpoints
     - Parameter completion: (Optional) Completion handler to execute after successful authorization.
     */
    func authorizeRp(issuerUrl: String?, configuration: OIDServiceConfiguration?, completion: (() -> Void)? = nil) {
        /**
         Performs authorization with an OIDC Provider configuration.

         A nested function to complete the authorization process after the OP's configuration has became available.

         - Parameter configuration: Ready to go OIDServiceConfiguration object populated with the OP's endpoints
         */
        func authorize(configuration: OIDServiceConfiguration) {
            print("Authorizing with configuration: \(configuration)")

            authorizeWithAutoCodeExchange(configuration: configuration,
                                          clientId: clientId,
                                          redirectionUri: redirectionUri) { authState, error in

                    if let authState = authState {
                        self.setAuthState(authState)

                        print("Successful authorization.")

                        self.showState()

                        if let completion = completion {
                            completion()
                        }
                    } else {
                        print("Authorization error: \(error?.localizedDescription ?? "")")

                        self.setAuthState(nil)
                    }
            }
        }

        if let issuerUrl = issuerUrl {
            // Discovering OP configuration
            discoverOIDServiceConfiguration(issuerUrl) { configuration, error in

                guard let configuration = configuration else {
                    print("Error retrieving discovery document for \(issuerUrl): \(error?.localizedDescription ?? "")")

                    self.setAuthState(nil)

                    return
                }

                authorize(configuration: configuration)
            }
        } else if let configuration = configuration {
            // Accepting passed-in OP configuration
            authorize(configuration: configuration)
        }
    }
}
