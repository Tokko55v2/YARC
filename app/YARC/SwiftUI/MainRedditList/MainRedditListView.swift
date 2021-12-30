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

    var body: some View {
        NavigationView {
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
                }).buttonStyle(PrimaryButton())

                Spacer()

                LogoView()
            }
        }
    }
}

struct ListView: View {
    @ObservedObject var viewModel: MainRedditListViewModel
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                AsyncImageView(url: "",
                               placeholder: {
                                   Text(R.string.localizable.isLoading_phrase())
                               })
                    .aspectRatio(contentMode: .fit)
            }
            .padding(.leading, 5)

            VStack(alignment: .leading) {
                Text("displayNamePrefixed")
                    .padding(.bottom, 5)
                    .font(.headline)
                    .foregroundColor(Color(R.color.textColor()!))
            }
            .padding(.horizontal, 5)

            Spacer()

            VStack(alignment: .trailing) {
                Button(action: {}, label: {
                    Image(systemName: "trash")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color(.black))
                })
            }
            .padding(.trailing, 16)
        }
        .frame(maxWidth: .infinity, minHeight: 55)
        .edgesIgnoringSafeArea(.all)
    }
}
