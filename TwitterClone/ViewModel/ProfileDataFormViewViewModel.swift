//
//  ProfileDataFormViewViewModel.swift
//  TwitterClone
//
//  Created by Dmitryi Velko on 20.12.2022.
//

import Foundation
import Combine

final class ProfileDataFormViewViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var userName: String?
    @Published var bio: String?
    @Published var avatarPath: String?
}
