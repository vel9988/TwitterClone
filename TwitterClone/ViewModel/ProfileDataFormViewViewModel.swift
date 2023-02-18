//
//  ProfileDataFormViewViewModel.swift
//  TwitterClone
//
//  Created by Dmitryi Velko on 20.12.2022.
//

import Foundation
import Combine
import UIKit
import FirebaseAuth
import FirebaseStorage

final class ProfileDataFormViewViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var userName: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    
    func validateUserProfileForm() {
        guard let displayName = displayName, displayName.count > 2,
              let userName = userName, userName.count > 2,
              let bio = bio, bio.count > 2,
              imageData != nil else {
            isFormValid = false
            return
        }
        isFormValid = true
    }
}
