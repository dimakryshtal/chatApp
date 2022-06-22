//
//  ChatRowViewModel.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 23.05.2022.
//

import Foundation
import Combine

extension ChatRow {
    class ViewModel: ObservableObject {
        var subscriptions = Set<AnyCancellable>()
        var chat: ChatRoom
        
        @Published var chatName: String?
        
        init(chatRoom: ChatRoom) {
            self.chat = chatRoom
        }
        
        func getChatName() {
            let user_id = chat.user_ids.first(where: {$0 != UserData.shared.getUserId()})
            UserNetworkManager.shared.getUsers(query: "?searchid=\(user_id!)")
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { response in
                    print("\(response)")
                }, receiveValue: {value in
                    print("\n\n\n\n\(UserData.shared.getUserChats())")
                    self.chatName = "\(value[0].firstName) \(value[0].lastName)"
                    self.chat.chatName = "\(value[0].firstName) \(value[0].lastName)"
                })
                .store(in: &subscriptions)
            
        }
    }
}

