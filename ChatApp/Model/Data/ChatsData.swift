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
    
    var cancellable = Set<AnyCancellable>()
    
    init(chat_ids: [String]) {
        print("\n\n\n \(chat_ids)")
        if(UserData.shared.getUserName() != "") {
            ChatRoomNetworkManager.shared.loadUserChatRooms(arrayOfChatIDs: chat_ids)
                .receive(on: DispatchQueue.main)

                .sink(receiveCompletion: { response in
                    print(response)
                }, receiveValue: { [self] data in
                    
                    self.chats = data.chats
                })
                .store(in: &cancellable)
        } 
    }
    
}
