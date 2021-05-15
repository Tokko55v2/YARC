//
//  LoginView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import SwiftUI

struct Entropy: View {
    @State var hasEntropy: Bool = false
    var body: some View {
        NavigationView {
            BackgroundColor()
                .overlay(
                    VStack {
                        Text(R.string.localizable.reddit_header())
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .padding(.top, 60)

                        Text(R.string.localizable.reddit_sub_header())
                            .font(.title)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 40)

                        Spacer()

                        LogoView()
                            .shadow(radius: 10)

                        Spacer()

                        Button(action: {
                            self.hasEntropy.toggle()
                        }, label: {
                            Text(R.string.localizable.no_login_button())
                        })
                            .buttonStyle(CustomButton())
                            .padding(.bottom, 60)

                        NavigationLink("", destination: MainView(showSubRedditView: true), isActive: $hasEntropy)
                    }
                    .padding([.leading, .trailing], 30)
                )
                .navigationBarHidden(true)
        }
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
        Entropy()
    }
}
