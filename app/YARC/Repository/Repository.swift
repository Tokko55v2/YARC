//
//  Repository.swift
//  YARC
//
//  Created by Michael Kroneder on 14/04/2021.
//

import Combine
import YARC_SDK

class Repository {
    func getPosts(_ prefix: String) -> AnyPublisher<Posts, YarcError> {
        YARCSDK.shared.module.getPosts(prefix)
    }

    func getMostPopularReddits() -> AnyPublisher<SubReddits, YarcError> {
        YARCSDK.shared.module.getMostPopularReddits()
    }

    func getImage(imgaeRequest: ImageRequest) -> AnyPublisher<ImageResponse, YarcError> {
        YARCSDK.shared.module.getImage(imgaeRequest: imgaeRequest)
    }
}
