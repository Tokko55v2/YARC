//
//  SubReddits.swift
//  RedditClient
//
//  Created by Michael Kroneder on 31/01/2021.
//

import Foundation

// swiftlint:disable identifier_name
struct SubReddit: Identifiable {
    var id: UUID
    var subscribers: Int64
    var display_name: String
    var title: String
    var display_name_prefixed: String
    var subreddit_type: String
    var over18: Bool
}

// swiftlint:disable identifier_name
extension SubReddit: Decodable, Hashable {
    enum CodingKeys: CodingKey {
        case subscribers
        case display_name
        case title
        case display_name_prefixed
        case subreddit_type
        case over18
        case data
    }

    init(from decoder: Decoder) throws {
        id = UUID()

        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        subscribers = try dataContainer.decode(Int64.self, forKey: .subscribers)
        display_name = try dataContainer.decode(String.self, forKey: .display_name)
        title = try dataContainer.decode(String.self, forKey: .title)
        display_name_prefixed = try dataContainer.decode(String.self, forKey: .display_name_prefixed)
        subreddit_type = try dataContainer.decode(String.self, forKey: .subreddit_type)
        over18 = try dataContainer.decode(Bool.self, forKey: .over18)
    }

    // swiftlint:disable operator_whitespace
    static func ==(lhs: SubReddit, rhs: SubReddit) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SubReddits {
    var subReddits = [SubReddit]()
}

// MARK: - Decodable

extension SubReddits: Decodable {
    enum CodingKeys: String, CodingKey {
        case subReddits = "children"
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        subReddits = try data.decode([SubReddit].self, forKey: .subReddits)
    }
}
