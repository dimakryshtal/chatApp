//
//  MainViewViewModel.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 29.04.2022.
//

import Foundation

class MainViewViewModel: ObservableObject{
    enum Tab {
        case chats
        case profile
    }
    
    @Published var tabSelection:Tab = .chats
    
    func initSocket(chatsData: ChatsData) {
        Socket.shared.connectToSocketServer()
        Socket.shared.initChats(chats: chatsData)
    }
    
}
