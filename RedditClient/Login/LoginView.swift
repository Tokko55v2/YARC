//
//  LoginView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import SwiftUI

struct LoginView: View {
    @State var username: String
    @State var password: String

    var body: some View {
        VStack {
            HStack {
                UserNameTextfield(username: username)
            }
            .background(Color.gray)

            HStack {
                SecureTextField(password: password)
            }
            .background(Color.gray)

            Button(R.string.localizable.login_button(), action: {
                print("Login clicked")
            })
        }
    }
}

struct UserNameTextfield: View {
    @State var username: String
    var body: some View {
        TextField(R.string.localizable.username_placeholder(), text: self.$username)
            .padding()
    }
}

struct SecureTextField: View {
    @State var password: String
    var body: some View {
        SecureField(R.string.localizable.password_placeholder(), text: self.$password)
            .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(username: "", password: "")
    }
}
