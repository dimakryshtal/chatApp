//
//  ChatsData.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 24.04.2022.
//

import Foundation
import Combine

final class ChatsData: ObservableObject {
    @Published var chats: [ChatRoom] = []
    @Published var messages: [Int: [Message]] = [:]{
        didSet {
            print("arrayChanged")
        }
    }
    
    
    var cancellable = Set<AnyCancellable>()
    
    init(chat_ids: [Int]) {
//        print("initialized")
//        print(chat_ids.count)
        ChatRoomNetworkManager.shared.loadUserChatRooms(arrayOfChatIDs: chat_ids)
            .receive(on: DispatchQueue.main)

            .sink(receiveCompletion: { response in
                print(response)
            }, receiveValue: { [self] data in
                self.chats = data.chats
//                print(self.chats)
            })
            .store(in: &cancellable)
        for (chat_id) in chat_ids {
            MessagesNetworkManager.shared.loadMessages(chat_id: chat_id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { response in
                    print("\(response)")
                }, receiveValue: { [self] messages in
                    self.messages[chat_id] = messages.messages
//                    print("\n \(messages)")
                })
                .store(in: &cancellable)
        }
    }
    
}
