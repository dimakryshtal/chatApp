//
//  ChatList.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI

struct ChatList: View {
    @EnvironmentObject var chatsData: ChatsData
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.blue.opacity(0.03)
                    .ignoresSafeArea()
                List {
                    ForEach(chatsData.chats, id: \.self) { chat in
                        NavigationLink {
                            Chat(chatData: chat, messages: $chatsData.messages)
                        } label: {
                            ChatRow()
                        }
                    }
                    .listRowBackground(Color.clear)
                    
                }
                .frame(maxWidth: .infinity)
                .listStyle(.plain)
            }
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList().preferredColorScheme(.light)
    }
}
