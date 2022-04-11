//
//  User.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 12.03.2022.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    var password: String?
    
//    enum CodingKeys: String, CodingKey {
//        case username
//        case firstName
//        case lastName
//        case email
//        case password
//    }
    
}
