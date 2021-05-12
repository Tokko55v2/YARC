//
//  Repository.swift
//  YARC
//
//  Created by Michael Kroneder on 14/04/2021.
//

import Combine
import YARC_SDK

class Repository {
    func dispatchLogin() -> AnyPublisher<Void, YarcError> {
        YARCSDK.shared.module.dispatchLogin()
    }

    func getPosts(_ prefix: String) -> AnyPublisher<Posts, YarcError> {
        YARCSDK.shared.module.getPosts(prefix)
    }

    func getSubReddit() -> AnyPublisher<SubReddit, YarcError> {
        YARCSDK.shared.module.getSubReddit()
    }

    func getSubscribedReddits() -> AnyPublisher<SubReddits, YarcError> {
        YARCSDK.shared.module.getSubscribedReddits()
    }

    func getMostPopularReddits() -> AnyPublisher<SubReddits, YarcError> {
        YARCSDK.shared.module.getMostPopularReddits()
    }

    func getImage(imgaeRequest: ImageRequest) -> AnyPublisher<ImageResponse, YarcError> {
        YARCSDK.shared.module.getImage(imgaeRequest: imgaeRequest)
    }
}
