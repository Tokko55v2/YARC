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
            ScrollView {
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

struct ListView: View {
    @ObservedObject var viewModel: MainRedditListViewModel
    @State var isPresented: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            VStack {
                AsyncImageView(url: "",
                               placeholder: { Text(R.string.localizable.isLoading_phrase()) })
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
        }
        .frame(maxWidth: .infinity, minHeight: 55)
        .background(Color(R.color.backgroundColorTwo()!))
        .edgesIgnoringSafeArea(.all)
    }
}
