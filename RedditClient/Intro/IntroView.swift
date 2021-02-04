//
//  IntroView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//

import SwiftUI

struct IntroView: View {
    @ObservedObject var viewModel = IntroViewModel()
    @ObservedObject var viewModelSubRedditView = SubRedditViewModel()
    @State var selectedRows = Set<SubReddit>()
    @Binding var passedIntro: Bool

    var body: some View {
        NavigationView {
            List(viewModel.subReddit.subReddits, selection: $selectedRows) { data in
                SelectMultiRow(imageLoader: ImageLoader(urlString: data.icon_img), selectedItems: $selectedRows, subReddit: data)
                    .frame(minHeight: 65)
            }
            .navigationBarTitle(R.string.localizable.popular_subReddits(), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(R.string.localizable.save_button()) {
                    self.viewModel.cacheProfile(selectedRows)
                    self.viewModelSubRedditView.refresh()
                    self.passedIntro = false
                }
            )
        }
    }
}

private struct SelectMultiRow: View {
    @ObservedObject var viewModel = IntroViewModel()
    @ObservedObject var imageLoader: ImageLoader
    @Binding var selectedItems: Set<SubReddit>
    var subReddit: SubReddit

    var isSelected: Bool {
        selectedItems.contains(subReddit)
    }

    var body: some View {
        HStack {
            VStack {
                Image(uiImage: imageLoader.image ?? UIImage())
                    .resizable()
                    .frame(width: 45, height: 45)
                    .background(Color(R.color.backgroundColorOne()!))
                    .clipShape(Capsule())
            }

            VStack(alignment: .leading) {
                Text(subReddit.title)
                    .font(.headline)
                Text("\(subReddit.subscribers) \(R.string.localizable.subscribers_title())")
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                if self.isSelected {
                    Image(systemName: "bookmark.fill")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color(R.color.backgroundColorTwo()!))
                } else {
                    Image(systemName: "bookmark")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color(R.color.backgroundColorTwo()!))
                }
            }
            .frame(minWidth: 35, maxHeight: 35)
            .onTapGesture {
                if self.isSelected {
                    self.selectedItems.remove(self.subReddit)
                } else {
                    self.selectedItems.insert(self.subReddit)
                }
            }
        }
    }
}
