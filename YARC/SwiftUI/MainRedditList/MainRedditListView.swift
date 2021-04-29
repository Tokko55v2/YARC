//
//  RedditPostsList.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import Rswift
import SwiftUI

struct MainRedditListView: View {
    @Environment(\.presentationMode) var mode
    @ObservedObject var viewModel: MainRedditListViewModel

    @FetchRequest(fetchRequest: YarcProfile.yarcFetchRequest)
    var yarcProfil: FetchedResults<YarcProfile>

    var body: some View {
        NavigationView {
            ScrollView {
                if !yarcProfil.isEmpty {
                    VStack(spacing: 0) {
                        ForEach(yarcProfil, id: \.self) { item in
                            NavigationLink(destination: SubRedditView(viewModel: SubRedditViewModel(item.displayNamePrefixed ?? ""), yarcProfil: item)
                                .background(Color(R.color.mainBackground()!))) {
                                    ListView(viewModel: viewModel, yarcProfile: item)
                            }
                            YARCDivider()
                        }
                    }
                } else {
                    VStack {
                        Text(R.string.localizable.no_subReddits_chosen())
                            .foregroundColor(Color(R.color.textColor()!))
                            .font(.headline)
                            .padding(.top, 10)

                        Spacer()

                        Button(action: {
                            viewModel.showIntroView.toggle()
                        }, label: {
                            Text(R.string.localizable.add_subReddits())
                        }).buttonStyle(CustomButton())

                        Spacer()

                        LogoView()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .principal, content: {
                    Text(R.string.localizable.mainReddit_list_title())
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        viewModel.showIntroView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                })
            })
            .sheet(isPresented: $viewModel.showIntroView, content: {
                RedditsView(viewModel: RedditsViewModel())
            })
        }
    }
}

struct ListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var viewModel: MainRedditListViewModel
    @State var isPresented: Bool = false
    var yarcProfile: YarcProfile

    var body: some View {
        HStack(spacing: 0) {
            VStack {
                AsyncImageView(url: yarcProfile.iconImg ?? "", placeholder: { Text(R.string.localizable.isLoading_phrase()) })
                    .aspectRatio(contentMode: .fit)
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
                                    self.viewModel.delete(item: yarcProfile, moc: managedObjectContext)
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
