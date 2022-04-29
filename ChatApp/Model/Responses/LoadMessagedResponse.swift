//
//  LoadMessagedResponse.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 25.04.2022.
//

import Foundation

struct MessagesResponse: Codable {
    var messages: [Message]
    var message: String
}
