//
//  IntroView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//

import SwiftUI

struct IntroView: View {
    @ObservedObject var viewModel = IntroViewModel()

    @State var selectedRows = Set<SubReddit>()

    var body: some View {
        NavigationView {
            List(viewModel.subReddit.subReddits, selection: $selectedRows) { data in
                SelectMultiRow(subReddit: data, selectedItems: $selectedRows)
                    .frame(minHeight: 65)
            }
            .navigationBarTitle(Text("Popular Subreddits"), displayMode: .inline)
        }
    }
}

private struct SelectMultiRow: View {
    @ObservedObject var viewModel = IntroViewModel()
    var subReddit: SubReddit

    @Binding var selectedItems: Set<SubReddit>

    var isSelected: Bool {
        selectedItems.contains(subReddit)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(subReddit.title)
                    .font(.headline)
                Text("\(subReddit.subscribers) subscribers")
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
