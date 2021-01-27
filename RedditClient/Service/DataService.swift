//
//  DataService.swift
//  RedditClient
//
//  Created by Michael Kroneder on 27/01/2021.
//

import Alamofire
import Combine
import Foundation

struct DataService {
    /// Singelton
    static let shared = DataService()

    func requestFetchPosts(completion: @escaping (Posts?, Error?) -> Void) {
        AF.request(ClientConstants.BASE_URL)
            .validate()
            .responseDecodable(of: Posts.self) { resonse in
                switch resonse.result {
                case let .failure(error):
                    completion(nil, error)
                case let .success(data):
                    completion(data, nil)
                }
            }
    }
}
