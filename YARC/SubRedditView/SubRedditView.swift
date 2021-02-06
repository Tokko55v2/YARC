//
//  RedditPostsList.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import Rswift
import SwiftUI

struct SubRedditView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var userSetting = UserDefaultsService()

    @FetchRequest(fetchRequest: YarcProfile.yarcFetchRequest)
    var yarcProfile: FetchedResults<YarcProfile>

    var body: some View {
        NavigationView {
            ScrollView {
                if !yarcProfile.isEmpty {
                    ForEach(yarcProfile, id: \.title) {
                        ListView(yarcProfile: $0)
                    }
                } else {
                    VStack {
                        Text("\(R.string.localizable.no_subReddits_chosen())")
                            .foregroundColor(Color(R.color.textColor()!))
                            .font(.headline)
                            .padding(.top, 10)
                        Spacer(minLength: 30)
                        Button("\(R.string.localizable.add_subReddits())") {
                            self.userSetting.initialProfileStatus.toggle()
                        }
                        .buttonStyle(CustomButton())
                        Spacer(minLength: 30)
                        LogoView()
                    }
                }
            }
            .navigationBarTitle(R.string.localizable.your_subReddits_title(), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.userSetting.initialProfileStatus.toggle()
            }) {
                    Image(systemName: "plus.circle.fill")
            })
            .sheet(isPresented: $userSetting.initialProfileStatus, content: {
                IntroView(passedIntro: self.$userSetting.initialProfileStatus)
                    .environment(\.managedObjectContext, managedObjectContext)
            })
        }
    }
}

private struct ListView: View {
    var yarcProfile: YarcProfile

    var body: some View {
        ZStack(alignment: .leading) {
            Color(R.color.backgroundColorTwo()!)
            HStack {
                VStack {
                    Image(uiImage: UIImage(data: yarcProfile.iconImageData ?? Data()) ?? UIImage())
                        .resizable()
                        .frame(width: 60, height: 60)
                        .background(Color(R.color.backgroundColorOne()!))
                        .clipShape(Capsule())
                }
                .padding(.bottom, 35)

                VStack(alignment: .leading) {
                    Text(yarcProfile.title ?? "")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)

                    Text(yarcProfile.displayNamePrefixed ?? "")
                        .padding(.bottom, 5)

                    HStack(alignment: .center) {
                        Text("\(yarcProfile.subscribers) \(R.string.localizable.members())")
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
