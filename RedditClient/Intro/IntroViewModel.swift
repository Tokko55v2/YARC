//
//  IntroViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//

import Alamofire
import Combine
import SwiftUI

class IntroViewModel: ObservableObject {
    private var dataService: DataService?
    @Published var subReddit: SubReddits

    init() {
        dataService = DataService()
        subReddit = SubReddits()
        fetchSubReddits()
    }

    func fetchSubReddits() {
        dataService?.requestSubReddits(completion: { data, error in
            if let error = error {
                print("\(error)")
                return
            }
            if let data = data {
                self.subReddit = data
            }
        })
    }
}
