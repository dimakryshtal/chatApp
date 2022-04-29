//
//  Message.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 25.04.2022.
//

import Foundation

struct Message: Codable, Hashable, Identifiable {
    var id: Int
    var user_id: Int
    var chat_id: Int
    var message: String
    var date: Date?
    
    enum CodingKeys: String, CodingKey {
        case id = "message_id"
        case user_id
        case chat_id
        case message
        case  date
    }
    
    static var defaultMessage = Message(id: 0, user_id: 0, chat_id: 0, message: "test")
}
