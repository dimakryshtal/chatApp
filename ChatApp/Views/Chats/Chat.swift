//
//  Chat.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI

struct Chat: View {
    @Namespace var bottomID
    var chatData: ChatRoom
    @Binding var messages: [Int:[Message]]
    
    var body: some View {
        
        ScrollViewReader { proxy in
            ZStack(alignment: .bottom) {
                Color.blue.opacity(0.03)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack {
                        ForEach(messages[chatData.chatRoom_id]!) { message in
                            ChatBubble(position: message.user_id == UserDefaults.standard.integer(forKey: "User_id") ? .right : .left) {
                                Text(message.message)
                            }
                        }
                    }
                }
                
                HStack {
                    FieldWithImage(fieldName: "Test", textValue: .constant("test"))
                        .frame(width: 300, height: 40)
                        .padding(.trailing, 10)
                    Image(systemName: "arrow.up.message")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                        
                }
                .frame(width: 390, height: 60)
                .background(Color.clear.background(.thinMaterial))
                .ignoresSafeArea()
            }
        }
        .navigationTitle("User")
        
        
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat(chatData: ChatRoom.defaultChatRoom, messages: .constant([0: [Message.defaultMessage]]))
    }
}
