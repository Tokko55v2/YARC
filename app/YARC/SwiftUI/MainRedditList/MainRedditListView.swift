//
//  RedditPostsList.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import Rswift
import SwiftUI

struct MainRedditListView: View {
    @StateObject var viewModel: MainRedditListViewModel = .init()

    var body: some View {
        VStack(spacing: 24) {
            Text("Welcome to YARC")
                .font(.headline)
                .padding()

            Spacer()

            LogoView()

            Spacer()

            Button(action: {
                viewModel.showIntroView.toggle()
            }, label: {
                Text(R.string.localizable.add_subReddits())
            })
                .buttonStyle(PrimaryButton())
                .padding(.bottom, 12)
        }
    }
}
