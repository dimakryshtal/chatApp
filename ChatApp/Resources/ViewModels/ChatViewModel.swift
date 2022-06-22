//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 08.05.2022.
//

import Foundation

extension Chat {
    class ChatViewModel: ObservableObject {
        @Published var newMessageValue = ""
        @Published var sendIsTapped = false
        
        var chatData: ChatRoom
        var messages: MessagesData
        var isJustCreated: Bool
        
        init(chatRoom: ChatRoom, messages: MessagesData) {
            self.chatData = chatRoom
            self.messages = messages
            isJustCreated = false
        }
        
        func sendMessage() {
            if newMessageValue == "" { return }
            
            let userId = UserData.shared.getUserId()
           
            let message = Message(id: "temp_id",
                                  user_id: userId,
                                  chat_id: chatData.id,
                                  message: newMessageValue,
                                  pending: true)
            
            newMessageValue = ""
            sendIsTapped = true
            
            let newMessageIndex = (messages.messages[chatData.id] ?? []).count
            
            messages.messages[chatData.id]?.append(message)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.sendIsTapped = false
            }
            Socket.shared.sendMessage(message: message) { id, date in
                self.messages.messages[self.chatData.id]![newMessageIndex].id = id
                self.messages.messages[self.chatData.id]![newMessageIndex].date = date
                self.messages.messages[self.chatData.id]![newMessageIndex].pending = nil
            }
        }
    }
}
