//
//  AppAuthViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 24/01/2021.
//

import AppAuth
import Foundation

extension LoginViewModel {
    /**
     Returns OIDC Provider configuration.

     In this method the endpoints are provided manually.
     */
    func getOIDCProviderConfiguration() -> OIDServiceConfiguration {
        let configuration = OIDServiceConfiguration(authorizationEndpoint: URL(string: "https://www.reddit.com/api/v1/authorize.compact")!,
                                                    tokenEndpoint: URL(string: "https://www.reddit.com/api/v1/access_token")!)

        return configuration
    }

    /**
     Returns OIDC Provider configuration.
     In this method the OP's endpoints are retrieved from the issuer's well-known OIDC configuration document location (asynchronously).
     The response is handled then with the passed in escaping callback.
     */
    func discoverOIDServiceConfiguration(_ issuerUrl: String, completion: @escaping (OIDServiceConfiguration?, Error?) -> Void) {
        // Checking if the issuer's URL can be constructed.
        guard let issuer = URL(string: issuerUrl) else {
            print("Error creating issuer URL for: \(issuerUrl)")

            return
        }

        print("Retrieving configuration for: \(issuer.absoluteURL)")

        // Discovering endpoints with AppAuth's convenience method.
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in

            // Completing with the caller's callback.
            completion(configuration, error)
        }
    }
}

extension LoginViewModel {
    /**
     Performs the authorization code flow.

     Attempts to perform a request to authorization endpoint by utilizing AppAuth's convenience method.
     Completes authorization code flow with automatic code exchange.
     The response is then passed to the completion handler, which lets the caller to handle the results.
     */
    func authorizeWithAutoCodeExchange(configuration: OIDServiceConfiguration,
                                       clientId: String,
                                       redirectionUri: String,
                                       scopes: [String] = [OIDScopeOpenID, OIDScopeProfile],
                                       completion: @escaping (OIDAuthState?, Error?) -> Void) {
        // Checking if the redirection URL can be constructed.
        guard let redirectURI = URL(string: redirectionUri) else {
            print("Error creating redirection URL for : \(redirectionUri)")

            return
        }

        // Checking if the AppDelegate property holding the authorization session could be accessed
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

        print("Initiating authorization request with scopes: \(request.scope ?? "no scope requested")")
        appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self) { authState, error in
            completion(authState, error)
        }
    }
}

extension LoginViewModel {
    /**
     Saves authorization state in a storage.

     As an example, the user's defaults database serves as the persistent storage.
     */
    func saveState() {
        var data: Data?

        if let authState = self.authState {
            if #available(iOS 12.0, *) {
                data = try! NSKeyedArchiver.archivedData(withRootObject: authState, requiringSecureCoding: false)
            } else {
                data = NSKeyedArchiver.archivedData(withRootObject: authState)
            }
        }

        UserDefaults.standard.set(data, forKey: authStateKey)
        UserDefaults.standard.synchronize()

        print("Authorization state has been saved.")
    }

    /**
     Reacts on authorization state changes events.
     */
    func stateChanged() {
        saveState()
    }

    /**
     Assigns the passed in authorization state to the class property.
     Assigns this controller to the state delegate property.
     */
    func setAuthState(_ authState: OIDAuthState?) {
        if self.authState != authState {
            self.authState = authState

            self.authState?.stateChangeDelegate = self

            stateChanged()
        }
    }

    /**
     Loads authorization state from a storage.

     As an example, the user's defaults database serves as the persistent storage.
     */
    func loadState() {
        guard let data = UserDefaults.standard.object(forKey: authStateKey) as? Data else {
            return
        }

        var authState: OIDAuthState?

        if #available(iOS 12.0, *) {
            // swiftlint:disable force_try
            authState = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? OIDAuthState
        } else {
            authState = NSKeyedUnarchiver.unarchiveObject(with: data) as? OIDAuthState
        }

        if let authState = authState {
            print("Authorization state has been loaded.")

            setAuthState(authState)
        }
    }

    /**
     Displays selected information from the current authorization data.
     */
    func showState() {
        print("Current authorization state: ")

        print("Access token: \(authState?.lastTokenResponse?.accessToken ?? "none")")

        print("ID token: \(authState?.lastTokenResponse?.idToken ?? "none")")

        print("Expiration date: \(String(describing: authState?.lastTokenResponse?.accessTokenExpirationDate))")
    }
}

extension LoginViewModel: OIDAuthStateChangeDelegate {
    /**
     Responds to authorization state changes in the AppAuth library.
     */
    func didChange(_ state: OIDAuthState) {
        print("Authorization state change event.")

        stateChanged()
    }
}

extension LoginViewModel: OIDAuthStateErrorDelegate {
    /**
     Reports authorization errors in the AppAuth library.
     */
    func authState(_ state: OIDAuthState, didEncounterAuthorizationError error: Error) {
        print("Received authorization error: \(error)")
    }
}
