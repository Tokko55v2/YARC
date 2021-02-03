//
//  LoginView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import SwiftUI
import WebKit

struct LoginView: View {
    @State var moveToListView: Bool = false
    @State var hasProfile: Bool = false

    var body: some View {
        BackgroundColor()
            .overlay(
                VStack {
                    Text(R.string.localizable.reddit_header())
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.top, 40)

                    Text(R.string.localizable.reddit_sub_header())
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 40)

                    Spacer()

                    LogoView()
                        .shadow(radius: 10)

                    Spacer()
                    Button(R.string.localizable.no_login_button()) {
                        self.hasProfile.toggle()
                    }
                    .buttonStyle(CustomButton())

                    Button(R.string.localizable.login_button()) {
                        LoginViewModel()
                            .doOauthReddit()
                    }
                    .buttonStyle(CustomButton())
                    .padding(.top, 30)
                    .padding(.bottom, 60)

                }.padding([.leading, .trailing], 27.5))
            .navigate(to: MainView(), when: $hasProfile)
            .edgesIgnoringSafeArea(.all)
    }
}

private struct BackgroundColor: View {
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
        LoginView()
    }
}
