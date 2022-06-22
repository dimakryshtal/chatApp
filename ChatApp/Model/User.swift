//
//  User.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 12.03.2022.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    var id: String?
    var firstName: String
    var lastName: String
    var username: String
    var email: String?
    var password: String?
    var userChats: [String]?
    var userFriends: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName
        case lastName
        case username
        case email
        case password
        case userChats
        case userFriends
    }
    
    
    
    static var defaultUser = User(id: "1111",
                                  firstName: "",
                                  lastName: "",
                                  username: "",
                                  email: "",
                                  password: "",
                                  userChats: ["00000.0"],
                                  userFriends: [])
}
