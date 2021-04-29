//
//  SubRedditViewModel.swift
//  YARC
//
//  Created by Michael Kroneder on 09/02/2021.
//

import Combine
import SwiftUI
import YARC_SDK

class SubRedditViewModel: ObservableObject {
    private var repository = Repository()
    private var store = Set<AnyCancellable>()
    private var prefix: String

    @Published var isLoading: Bool = false
    @Published var posts: Posts?

    init(_ prefix: String) {
        self.prefix = prefix
    }

    func getPosts() {
        setIsLoading(true)
        repository.getPosts(prefix)
            .sink(receiveCompletion: { completion in
                self.setIsLoading(false)
                switch completion {
                case let .failure(error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { posts in
                self.posts = posts
            })
            .store(in: &store)
    }

    func convertTimeStamp(_ timeStamp: Double) -> String {
        let now = Date().timeIntervalSince1970

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour]
        formatter.unitsStyle = .abbreviated
        let formatted = formatter.string(from: Double(Int(now)) - timeStamp)
        return formatted ?? ""
    }

    func setIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
        }
    }
}
