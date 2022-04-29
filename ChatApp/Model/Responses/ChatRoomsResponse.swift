//
//  ChatRoomsResponse.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 23.04.2022.
//

import Foundation

struct ChatRoomsResponse: Codable {
    var chats: [ChatRoom]
    var message: String
}
