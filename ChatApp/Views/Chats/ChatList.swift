//
//  ChatList.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI
import Combine

struct ChatList: View {
    @EnvironmentObject var chatsData: ChatsData
    @EnvironmentObject var messagesData: MessagesData
    @State private var selectedChat: ChatRoom?
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.blue.opacity(0.03)
                    .ignoresSafeArea()
                List {
                    ForEach(chatsData.chats) { chat in
                        
                        Button {
                            selectedChat = chat
                        } label: {
                            ChatRow(chatRoom: chat)
                                
                        }
                        .listRowInsets(EdgeInsets())
                        .buttonStyle(CustomListButtonStyle())
                        
                        
                    }
                    .listRowBackground(Color.clear)
                    .fullScreenCover(item: $selectedChat, content: { item in

                        Chat(chatRoom: item, messages: messagesData, name: item.chatName ?? "User")
                    })
                    

                }
                .frame(maxWidth: .infinity)
                .listStyle(.plain)
            }
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList().preferredColorScheme(.light)
            .environmentObject(ChatsData(chat_ids: ["00000.0"]))
    }
}
