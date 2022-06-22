//
//  ChatRoom.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 23.04.2022.
//

import Foundation
import Combine

class ChatRoom: Codable, Equatable, Identifiable{
    static func == (lhs: ChatRoom, rhs: ChatRoom) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    var chatName: String?
    var chatType: String
    var user_ids: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case chatName
        case chatType
        case user_ids
    }
    
    init(id: String, chatName: String?, chatType: String, user_ids: [String]) {
        self.id = id
        self.chatType = chatType
        self.chatName = chatName
        self.user_ids = user_ids
    }
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        chatType = try values.decode(String.self, forKey: .chatType)
        user_ids = try values.decode([String].self, forKey: .user_ids)
        
    }
    
    static var defaultChatRoom = ChatRoom(id: "000000.0", chatName: "Test Chat", chatType: "", user_ids: ["1234","2222"])
}
