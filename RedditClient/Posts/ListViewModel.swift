//
//  ListViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 26/01/2021.
//

import Alamofire
import Combine
import SwiftUI

class ListViewModel: ObservableObject {
    private var dataService: DataService?

    @Published var posts = Posts()

    init() {
        dataService = DataService()
        fetchPosts()
    }

    func fetchPosts() {
        dataService?.requestFetchPosts(completion: { posts, error in
            if let error = error {
                print("\(error)")
                return
            }
            self.posts = posts ?? Posts()
        })
    }
}
