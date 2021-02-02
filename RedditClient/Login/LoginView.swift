//
//  LoginView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import SwiftUI
import WebKit

// swiftlint:disable multiple_closures_with_trailing_closure
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

                    ImageView()
                        .shadow(radius: 10)

                    Spacer()
                    Button(action: {
                        self.hasProfile.toggle()
                    }) {
                            Text(R.string.localizable.no_login_button())
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 60)
                                .background(Color(R.color.buttonColor()!))
                                .cornerRadius(15.0)
                    }
                    Button(action: {
                        LoginViewModel()
                            .doOauthReddit()
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
                    .padding(.bottom, 60)

                }.padding([.leading, .trailing], 27.5))
            .navigate(to: MainView(), when: $hasProfile)
            .edgesIgnoringSafeArea(.all)
    }
}

private struct ImageView: View {
    var body: some View {
        guard let img = R.image.logo() else {
            fatalError("Unable to load image")
        }

        return Image(uiImage: img)
            .resizable()
            .frame(width: 250, height: 250)
            .padding(.bottom, 50)
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
