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
    @ObservedObject var coreDataServie = CoreDataService()

    @FetchRequest(fetchRequest: YarcProfile.yarcFetchRequest)
    var yarcProfile: FetchedResults<YarcProfile>

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    if !yarcProfile.isEmpty {
                        ForEach(yarcProfile, id: \.title) { yarcContent in
                            Divider()
                            NavigationLink(destination: Dummy(yarcProfile: yarcContent)) {
                                ListView(yarcProfile: yarcContent)
                            }
                            Divider()
                        }
                    } else {
                        VStack {
                            Text("\(R.string.localizable.no_subReddits_chosen())")
                                .foregroundColor(Color(R.color.textColor()!))
                                .font(.headline)
                                .padding(.top, 10)
                            Spacer()
                            Button("\(R.string.localizable.add_subReddits())") {
                                self.userSetting.initialProfileStatus.toggle()
                            }
                            .buttonStyle(CustomButton())
                            Spacer()
                            LogoView()
                        }
                    }
                }
            }
            .background(Color(R.color.backgroundScrollView()!))
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

struct Dummy: View {
    var yarcProfile: YarcProfile
    var body: some View {
        Text("\(yarcProfile.title ?? "")")
    }
}

struct ListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var coreDataServie = CoreDataService()
    @State var isPresented: Bool = false
    var yarcProfile: YarcProfile

    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Image(uiImage: UIImage(data: yarcProfile.iconImageData ?? Data()) ?? UIImage())
                    .resizable()
                    .frame(width: 35, height: 35)
                    .background(Color(R.color.backgroundColorOne()!))
                    .clipShape(Capsule())
            }
            .padding(.leading, 5)

            VStack(alignment: .leading) {
                Text(yarcProfile.displayNamePrefixed ?? "")
                    .padding(.bottom, 5)
                    .font(.headline)
                    .foregroundColor(Color(R.color.textColor()!))
            }
            .padding(.horizontal, 5)

            Spacer()

            VStack(alignment: .trailing) {
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    Image(systemName: "trash")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color(.black))
                }).actionSheet(isPresented: $isPresented) {
                    ActionSheet(title: Text(R.string.localizable.delete_button_message_subReddit()),
                                message: nil,
                                buttons: [.default(Text(R.string.localizable.delete_button_test())) {
                                    self.coreDataServie.deleteSubReddit(yarcProfile, moc: managedObjectContext)
                                },
                                .cancel()])
                }
            }
            .padding(.trailing, 16)
        }
        .frame(maxWidth: .infinity, minHeight: 55)
        .background(Color(R.color.backgroundColorTwo()!))
        .edgesIgnoringSafeArea(.all)
    }
}
