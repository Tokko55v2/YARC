//
//  IntroViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//

import Combine
import CoreData
import SwiftUI
import YARC_SDK

class RedditsViewModel: ObservableObject {
    let repository = Repository()
    var store = Set<AnyCancellable>()

    @Published var selectedItem = Set<SubReddit>()
    @Published var mostPoular: SubReddits?

    internal init() {
        initialReddits()
    }

    func initialReddits() {
        repository.getMostPopularReddits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.mostPoular = response
            })
            .store(in: &store)
    }

    func removeSelectedItem(_ item: SubReddit) {
        selectedItem.remove(item)
    }

    func insertSelectedItem(_ item: SubReddit) {
        selectedItem.insert(item)
    }
}
