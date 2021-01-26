//
//  RedditPostsList.swift
//  RedditClient
//
//  Created by Michael Kroneder on 23/01/2021.
//

import Rswift
import SwiftUI

struct ListMainView: View {
    var body: some View {
        ListView()
            .navigationTitle(R.string.localizable.reddit_header())
    }
}

struct ListView: View {
    var array: [String] = ["", "", "", "", "", "", ""]

    var body: some View {
        ZStack {
            List(array, id: \.self) { _ in
                RowView()
            }
        }
        .background(RowBackgroundColor())
    }
}

struct RowView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Title").font(.system(size: 15.0))
                Text("Author").font(.system(size: 12.0))
                Text("URL").font(.system(size: 10.0)).foregroundColor(Color.gray)
            }
            Spacer()
            VStack {
                HStack {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(R.color.backgroundColorTwo()!))
                    Text("3")
                }
                HStack {
                    Image(systemName: "arrow.down")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(R.color.backgroundColorOne()!))
                    Text("50")
                }
                HStack {
                    Image(systemName: "bubble.left.and.bubble.right")
                        .font(.system(size: 16, weight: .semibold))
                    Text("2")
                }
            }.padding(.leading)
        }
    }
}

struct RowBackgroundColor: View {
    var body: some View {
        EmptyView()
            .background(Color(R.color.headerColor()!))
            .edgesIgnoringSafeArea(.all)
    }
}

struct ListMainView_Previews: PreviewProvider {
    static var previews: some View {
        ListMainView()
    }
}
