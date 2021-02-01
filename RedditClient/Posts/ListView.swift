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
    }
}

private struct ListView: View {
    @ObservedObject var viewModel = ListViewModel()
    var body: some View {
        ZStack {
            List(viewModel.posts.posts) { post in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(post.title)").font(.system(size: 15.0))
                        Text("\(post.author)").font(.system(size: 12.0))
                        Text("\(post.url)").font(.system(size: 10.0)).foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(R.color.backgroundColorTwo()!))
                            Text("\(post.ups)")
                        }
                        HStack {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(R.color.backgroundColorOne()!))
                            Text("\(post.downs)")
                        }
                        HStack {
                            Image(systemName: "bubble.left.and.bubble.right")
                                .font(.system(size: 16, weight: .semibold))
                            Text("\(post.numComments)")
                        }
                    }.padding(.leading)
                }
            }
        }
    }
}

private struct ListMainView_Previews: PreviewProvider {
    static var previews: some View {
        ListMainView()
    }
}
