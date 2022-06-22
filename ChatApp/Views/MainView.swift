//
//  MainView.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI
import SocketIO
import Introspect

struct MainView: View {
    @StateObject private var chatsData = ChatsData(chat_ids: UserData.shared.getUserChats())
    @StateObject private var messagesData = MessagesData(chat_ids: UserData.shared.getUserChats())
    @StateObject private var friendsData = FriendsData(friendsIds: UserData.shared.getUserFriends())
    
    @State var tabSelection:Tab = .chats
    enum Tab {
        case chats
        case friends
        case profile
    }
    

    var body: some View {
            TabView{
                ChatList()
                    .tabItem {
                        Label("Chats", systemImage: "mail")
                    }
                    .tag(Tab.chats)
                
                Friends()
                    .tabItem {
                        Label("Friends", systemImage: "person.2.fill")
                    }
                    .tag(Tab.friends)
                
                
                Profile()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    .tag(Tab.profile)
            }
            .environmentObject(chatsData)
            .environmentObject(messagesData)
            .environmentObject(friendsData)
            .onAppear {
                initSocket()
            }

    }
    
    func initSocket() {
        Socket.shared.connectToSocketServer()
        Socket.shared.initChats(chats: chatsData, messages: messagesData)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
