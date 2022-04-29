//
//  ChatRoom.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 23.04.2022.
//

import Foundation

struct ChatRoom: Codable, Hashable{
    var chatRoom_id: Int
    var chatType: String
    var user_ids: [Int]
    
    static var defaultChatRoom = ChatRoom(chatRoom_id: 0, chatType: "", user_ids: [0,1])
}
