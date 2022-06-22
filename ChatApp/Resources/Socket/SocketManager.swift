//
//  SocketManager.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 27.04.2022.
//

import Foundation
import SocketIO
import SwiftUI

struct UserInit: SocketData {
    var user_id: String
    var chats: [String]
    
    func socketRepresentation() -> SocketData {
        return ["user_id": user_id, "chats": chats]
    }
}

struct MessageSocketData: SocketData {
    var user_id: String
    var chat_id: String
    var message: String
    
    func socketRepresentation() throws -> SocketData {
        return ["user_id": user_id, "chat_id": chat_id, "message": message];
    }
}

struct ChatSocketData: SocketData {
    var chatType: String
    var user_ids: [String]
    
    func socketRepresentation() throws -> SocketData {
        return ["chatType": chatType, "user_ids": user_ids]
    }
}

class Socket {
    static let shared = Socket()
    var manager: SocketManager
    var socket:SocketIOClient
    var chats: ChatsData?
    var messages: MessagesData?
    
    init () {
        manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
    }
}


extension Socket {
    
    func initChats(chats: ChatsData, messages: MessagesData) {
        self.chats = chats
        self.messages = messages
        
    }
    
    func connectToSocketServer() {
        let user = UserInit(user_id: UserData.shared.getUserId(),
                            chats: UserData.shared.getUserChats() ?? [])



        socket.on(clientEvent: .connect) { [self]data, ack in
            print("socket connected")
            socket.emit("inituser", user)
        }
        socket.on("new message") { data, ack in
            if let arr = data as? [[String: Any]],
               let id = arr[0]["_id"] as? String,
               let chat_id = arr[0]["chat_id"] as? String,
               let message = arr[0]["message"] as? String,
               let user_id = arr[0]["user_id"] as? String {
                self.messages?.messages[chat_id]?.append(Message(id: id, user_id: user_id, chat_id: chat_id, message: message))
            }

        }
        
        socket.on("chat created") { data, ack in
            if let arr = data as? [[String: Any]],
               let id = arr[0]["id"] as? String,
               let chatType = arr[0]["chatType"] as? String,
               let user_ids = arr[0]["user_ids"] as? [String] {
                self.chats?.chats.append(ChatRoom(id: id, chatName: nil, chatType: chatType, user_ids: user_ids))
                self.messages?.messages[id] = []
            }
        }
        
        socket.connect()
    }
    
    func sendMessage( message: Message, completion: @escaping (String, String) -> Void){
        let messageSocketData = MessageSocketData(user_id: message.user_id, chat_id: message.chat_id, message: message.message);
        
        socket.emitWithAck("chat message", messageSocketData).timingOut(after: 1) { data in
            if let messageObj = data as? [[String: Any]],
               let id = messageObj[0]["id"] as? String,
               let date = messageObj[0]["date"] as? String {
                completion(id, date)
                print(messageObj)
            }
            
        }
    }
    
    func createNewChat(chat: ChatRoom, completion: @escaping(String) -> Void) {
        let chatSocketData = ChatSocketData(chatType: chat.chatType, user_ids: chat.user_ids)
        
        socket.emitWithAck("new chat", chatSocketData).timingOut(after: 1) { data in
            if let chatObj = data as? [[String: Any]],
               let id = chatObj[0]["id"] as? String {
                completion(id)
                print("\n\n\n \(id)")
            }
        }
    }
    
    func disconnect() {
        socket.disconnect()
    }
}
