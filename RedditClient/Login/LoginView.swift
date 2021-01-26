//
//  LoginView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import SwiftUI

// swiftlint:disable multiple_closures_with_trailing_closure
struct LoginView: View {
    @State var username: String
    @State var password: String
    @State var moveToListView: Bool = false

    var body: some View {
        BackgroundColor()
            .overlay(
                VStack {
                    Text("Reddit Client")
                        .font(.largeTitle).foregroundColor(Color.white)
                        .padding([.top, .bottom], 40)

                    ImageView()
                        .shadow(radius: 10)

                    Spacer()

                    UserNameTextfield(username: username)
                    SecureTextField(password: password)

                    Button(action: {
                        self.moveToListView.toggle()
                    }) {
                            Text(R.string.localizable.login_button())
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 60)
                                .background(Color(R.color.buttonColor()!))
                                .cornerRadius(15.0)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 30)

                }.padding([.leading, .trailing], 27.5))
            .navigate(to: ListMainView(), when: $moveToListView)
    }
}

struct ImageView: View {
    var body: some View {
        guard let img = R.image.logo() else {
            fatalError("Unable to load image")
        }

        return Image(uiImage: img)
            .resizable()
            .frame(width: 200, height: 200)
            .padding(.bottom, 50)
    }
}

struct UserNameTextfield: View {
    @State var username: String
    var body: some View {
        TextField(R.string.localizable.username_placeholder(), text: self.$username)
            .padding()
            .cornerRadius(20.0)
            .background(Color(R.color.backgroundTextFields()!))
    }
}

struct SecureTextField: View {
    @State var password: String
    var body: some View {
        SecureField(R.string.localizable.password_placeholder(), text: self.$password)
            .padding()
            .cornerRadius(20.0)
            .background(Color(R.color.backgroundTextFields()!))
    }
}

struct BackgroundColor: View {
    var body: some View {
        Color(hex: "")
            .background(
                LinearGradient(gradient:
                    Gradient(colors: [Color(R.color.backgroundColorOne()!),
                                      Color(R.color.backgroundColorTwo()!)]),
                    startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(username: "", password: "")
    }
}
