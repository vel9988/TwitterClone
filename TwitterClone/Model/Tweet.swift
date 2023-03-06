//
//  Tweet.swift
//  TwitterClone
//
//  Created by Dmitryi Velko on 03.03.2023.
//

import Foundation

struct Tweet: Codable {
    var id = UUID().uuidString
    let author: TwitterUser
    let tweetContent: String
    let likesCount: Int
    let likers: [String]
    let isReply: Bool
    let parentReference: String?
}
