//
//  MainView.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI
import SocketIO

struct MainView: View {
    @StateObject private var chatsData = ChatsData(chat_ids: (UserDefaults.standard.value(forKey: "UserChats")) as! [Int])
    @StateObject private var viewModel = MainViewViewModel()
    
    
    enum Tab {
        case chats
        case profile
    }
    

    var body: some View {
            TabView{
                ChatList()
                    .tabItem {
                        Label("Chats", systemImage: "mail")
                    }
                    .environmentObject(chatsData)
                    .tag(Tab.chats)
                
                Profile()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
            }
            .onAppear {
                viewModel.initSocket(chatsData: chatsData)
//                viewModel.initSocket(chatsData: chatsData)
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
