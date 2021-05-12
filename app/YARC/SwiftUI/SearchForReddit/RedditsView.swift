//
//  RedditsView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//

import SwiftUI
import YARC_SDK

struct RedditsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var mode
    @ObservedObject var viewModel: RedditsViewModel

    var body: some View {
        NavigationView {
            if viewModel.mostPoular != nil {
                List(viewModel.mostPoular!.subReddits, selection: $viewModel.selectedItem) { selected in
                    SelectReddits(viewModel: self.viewModel, subReddit: selected)
                        .frame(minHeight: 60)
                }
                .navigationBarTitle(R.string.localizable.popular_subReddits(), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.viewModel.saveItems(moc: managedObjectContext)
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text(R.string.localizable.save_button())
                }))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .modifier(LoadingModifier(isShowing: .constant(viewModel.mostPoular == nil)))
    }
}

private struct SelectReddits: View {
    @ObservedObject var viewModel: RedditsViewModel
    var subReddit: SubReddit

    var isSelected: Bool {
        viewModel.selectedItem.contains(subReddit)
    }

    init(viewModel: RedditsViewModel, subReddit: SubReddit) {
        self.viewModel = viewModel
        self.subReddit = subReddit
    }

    var body: some View {
        HStack {
            VStack {
                AsyncImageView(url: subReddit.icon_img,
                               placeholder: { Text(R.string.localizable.isLoading_phrase()) })
                    .aspectRatio(contentMode: .fit)
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
                    self.viewModel.removeSelectedItem(self.subReddit)
                } else {
                    self.viewModel.insertSelectedItem(self.subReddit)
                }
            }
        }
    }
}
