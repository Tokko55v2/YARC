//
//  RedditPostsList.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import Rswift
import SwiftUI

struct SubRedditView: View {
    @ObservedObject var viewModel = SubRedditViewModel()
    @State var passedIntro: Bool = true

    var body: some View {
        ScrollView {
            if let profile = viewModel.profile.subReddit {
                ForEach(profile) { subReddit in
                    ListView(profileSubReddit: subReddit, imageLoader: ImageLoader(urlString: subReddit.iconImg))
                }
            } else {
                VStack {
                    Text("\(R.string.localizable.no_subReddits_chosen())")
                        .font(.headline)
                        .padding(.top, 10)
                    Spacer(minLength: 30)
                    Button("\(R.string.localizable.add_subReddits())") {
                        self.passedIntro.toggle()
                    }
                    .buttonStyle(CustomButton())
                    Spacer(minLength: 30)
                    LogoView()
                }
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
        .background(Color(R.color.backgroundColorOne()!))
        .onAppear {
            self.viewModel.refresh()
        }
        .sheet(isPresented: $passedIntro, content: {
            IntroView(viewModelSubRedditView: viewModel, passedIntro: self.$passedIntro)
        })
    }
}

private struct ListView: View {
    var profileSubReddit: ProfileSubReddit
    var imageLoader: ImageLoader

    var body: some View {
        ZStack(alignment: .leading) {
            Color(R.color.backgroundColorTwo()!)
            HStack {
                VStack {
                    Image(uiImage: imageLoader.image ?? UIImage())
                        .resizable()
                        .frame(width: 60, height: 60)
                        .background(Color(R.color.backgroundColorOne()!))
                        .clipShape(Capsule())
                }
                .padding(.bottom, 35)

                VStack(alignment: .leading) {
                    Text(profileSubReddit.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)

                    Text(profileSubReddit.displayNamePrefixed)
                        .padding(.bottom, 5)

                    HStack(alignment: .center) {
                        Text("\(profileSubReddit.subscribers) \(R.string.localizable.members())")
                    }
                    .padding(.bottom, 5)
                }
                .padding(.horizontal, 5)

                Spacer()

                VStack(alignment: .trailing) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 25, weight: .regular))
                        .foregroundColor(Color(.white))
                }
            }
            .padding(15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(maxHeight: 100, alignment: .center)
        .padding([.leading, .trailing, .top], 20)
        .padding(.top, 15)
    }
}

private struct ListMainView_Previews: PreviewProvider {
    static var previews: some View {
        SubRedditView()
    }
}
