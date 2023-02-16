//
//  TwitterUser.swift
//  TwitterClone
//
//  Created by Dmitryi Velko on 20.12.2022.
//

import Foundation
import Firebase

struct TwitterUser: Codable {
    let id: String
    var displayName: String = ""
    var userName: String = ""
    var followersCount: Double = 0
    var followingCount: Double = 0
    var createOn: Date = Date()
    var bio: String = ""
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false
    
    init(from user: User) {
        self.id = user.uid
    }
    
}
