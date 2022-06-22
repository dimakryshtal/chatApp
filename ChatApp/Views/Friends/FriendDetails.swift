//
//  FriendDetails.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 12.05.2022.
//

import SwiftUI

struct FriendDetails: View {
    @State private var chatPresented = false
    @EnvironmentObject var chatsData: ChatsData
    @EnvironmentObject var messages: MessagesData
    var user: User
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.03)
                .ignoresSafeArea()
            VStack {
                HStack {
                    CircleImage(image: Image("kitty"))
                        .frame(width: 80, height: 80)
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.system(size: 25))
                    Spacer()
                }
                .padding([.leading,.trailing,.bottom], 15)
                .background(Color.gradientColor1.opacity(0.8))
                .foregroundColor(.white)
                
                Button("Create chat") {
                    let newChat = ChatRoom(id: "temp.id",
                                           chatName: "\(user.firstName) \(user.lastName)",
                                           chatType: "private",
                                           user_ids: [UserData.shared.getUserId(), user.id!])
                    let index = chatsData.chats.count
                    chatsData.chats.append(newChat)
                    Socket.shared.createNewChat(chat: newChat) { id in
                        chatsData.chats[index].id = id
                    }
                    
                    self.chatPresented.toggle()
                }
                .fullScreenCover(isPresented: $chatPresented, content: {
                    Chat(chatRoom: chatsData.chats.last ?? ChatRoom.defaultChatRoom,
                         messages: messages,
                         name: "\(user.firstName) \(user.lastName)")
                })
                .buttonStyle(CustomButtonStyle())
                Spacer()
                
                
            }
        }
    }
}

struct FriendDetails_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetails(user: User.defaultUser)
    }
}
