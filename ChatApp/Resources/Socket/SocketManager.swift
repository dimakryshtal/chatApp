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
    var user_id: Int
    var chats: [Int]
    
    func socketRepresentation() -> SocketData {
        return ["user_id": user_id, "chats": chats]
    }
}

class Socket {
    static let shared = Socket()
    var manager: SocketManager
    var socket:SocketIOClient
    var chats: ChatsData?
    
    init () {
        manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
    }
}


extension Socket {
    
    func initChats(chats: ChatsData) {
        self.chats = chats
    }
    
    func connectToSocketServer() {
        let user = UserInit(user_id: UserDefaults.standard.value(forKey: "User_id") as! Int,
                            chats: UserDefaults.standard.value(forKey: "UserChats") as! [Int])



        socket.on(clientEvent: .connect) { [self]data, ack in
            print("socket connected")
            socket.emit("inituser", user)
        }
        socket.on("new message") { data, ack in
            if let arr = data as? [[String: Any]],
               let id = arr[0]["message_id"] as? Int,
               let chat_id = arr[0]["chat_id"] as? Int,
               let message = arr[0]["message"] as? String,
               let user_id = arr[0]["user_id"] as? Int {
                self.chats?.messages[chat_id]?.append(Message(id: id, user_id: user_id, chat_id: chat_id, message: message))
                print(self.chats?.messages[chat_id])
            }

        }
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
}
