//
//  LoginResponse.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 19.04.2022.
//

import Foundation

struct LoginResponse: Codable {
    var user: User
    var token: String
    var refreshToken: String
}
