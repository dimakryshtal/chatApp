//
//  MessagesData.swift

//  ChatApp
//
//  Created by Dima Kryshtal on 09.05.2022.
//

import Foundation
import Combine

final class MessagesData: ObservableObject {
    @Published var messages: [String: [Message]] = [:]{
        didSet {
            print("arrayChanged")
        }
    }
    
    
    var cancellable = Set<AnyCancellable>()
    
    init(chat_ids: [String]) {
        for (chat_id) in chat_ids {
            MessagesNetworkManager.shared.loadMessages(chat_id: chat_id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { response in
                    print("\(response)")
                }, receiveValue: { [self] messages in
                    self.messages[chat_id] = messages.messages
                    print("\n\n\n \(messages)")
                })
                .store(in: &cancellable)
        }
    }
}


