//
//  IntroViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//

import Alamofire
import CoreData
import SwiftUI

class IntroViewModel: ObservableObject {
    @Published var subReddit: SubReddits
    private var dataService: DataService?

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
