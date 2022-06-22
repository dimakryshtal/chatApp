//
//  Message.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 25.04.2022.
//

import Foundation

struct Message: Codable, Identifiable, Equatable {
    var id: String
    var user_id: String
    var chat_id: String
    var message: String
    var date: String?
    var pending: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user_id
        case chat_id
        case message
        case date
        case pending
    }
    
    static var defaultMessage = Message(id: "000000000.0.0", user_id: "1111", chat_id: "00000.0", message: "test")
    
    mutating func changeMessageStatus() {
        pending = nil
    }
}
