//
//  Post.swift
//  RedditClient
//
//  Created by Michael Kroneder on 24/01/2021.
//

import Foundation

struct Post: Identifiable {
    let id: String
    var title: String
    var author: String
    var url: String
    var ups: Int
    var downs: Int
    var numComments: Int
    var permalink: String
}

// MARK: - Decodable

extension Post: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case title
        case author
        case url
        case ups
        case downs
        case data
        // swiftlint:disable identifier_name
        case num_comments
        case permalink
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        url = try dataContainer.decode(String.self, forKey: .url)
        ups = try dataContainer.decode(Int.self, forKey: .ups)
        downs = try dataContainer.decode(Int.self, forKey: .downs)
        numComments = try dataContainer.decode(Int.self, forKey: .num_comments)
        permalink = try dataContainer.decode(String.self, forKey: .permalink)
    }
}

struct Posts {
    var posts = [Post]()
}

// MARK: - Decodable

extension Posts: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "children"
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        posts = try data.decode([Post].self, forKey: .posts)
    }
}
