//
//  DatabaseManager.swift
//  TwitterClone
//
//  Created by Dmitryi Velko on 20.12.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    let userPath = "users"
    
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwitterUser(from: user)
        return db.collection(userPath).document(twitterUser.id).setData(from: twitterUser)
            .map { _ in return true }
            .eraseToAnyPublisher()
    }
    
    func collectionUsers(retrieve id: String) -> AnyPublisher<TwitterUser, Error> {
        db.collection(userPath).document(id).getDocument()
            .tryMap { try $0.data(as: TwitterUser.self) }
            .eraseToAnyPublisher()
    }
}
