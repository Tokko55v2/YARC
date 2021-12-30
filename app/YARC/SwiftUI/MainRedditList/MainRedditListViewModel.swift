//
//  ListViewModel.swift
//  RedditClient
//
//  Created by Michael Kroneder on 26/01/2021.
//

import Combine
import CoreData
import SwiftUI

class MainRedditListViewModel: ObservableObject {
    let repository = Repository()
    var store = Set<AnyCancellable>()

    @Published var showIntroView: Bool = false
}
