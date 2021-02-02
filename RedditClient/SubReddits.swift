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
    var primary_color: String
    var icon_img: String
    var public_description: String
    var banner_background_color: String
    var url: String
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
        case primary_color
        case icon_img
        case public_description
        case banner_background_color
        case url
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
        primary_color = try dataContainer.decode(String.self, forKey: .primary_color)
        icon_img = try dataContainer.decode(String.self, forKey: .icon_img)
        public_description = try dataContainer.decode(String.self, forKey: .public_description)
        banner_background_color = try dataContainer.decode(String.self, forKey: .banner_background_color)
        url = try dataContainer.decode(String.self, forKey: .url)
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
