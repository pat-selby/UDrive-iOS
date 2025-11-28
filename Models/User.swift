//
//  User.swift
//  UDrive
//
//  Created on 2024
//

import Foundation

enum UserType: String, Codable {
    case student
    case driver
}

struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var email: String
    var userType: UserType
    var phoneNumber: String?
    var profileImageURL: String?
    
    init(id: UUID = UUID(), name: String, email: String, userType: UserType, phoneNumber: String? = nil, profileImageURL: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.userType = userType
        self.phoneNumber = phoneNumber
        self.profileImageURL = profileImageURL
    }
}

