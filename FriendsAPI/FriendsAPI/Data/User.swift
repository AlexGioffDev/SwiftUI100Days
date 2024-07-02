//
//  User.swift
//  FriendsAPI
//
//  Created by Alex Gioffre' on 30/06/24.
//

import Foundation

struct User: Codable, Hashable {
    
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company, email, address, about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
}
