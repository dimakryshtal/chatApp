//
//  ChatRoomNetworkManager.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 24.04.2022.
//

import Foundation
import Combine

protocol ChatRoomsNetworkManagerDelegate {
    func loadUserChatRooms(arrayOfChatIDs: [Int]) -> AnyPublisher <ChatRoomsResponse, Error>
}

final class ChatRoomNetworkManager {
    static let shared = ChatRoomNetworkManager()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init() {
        encoder.outputFormatting = .prettyPrinted
    }
}

extension ChatRoomNetworkManager: ChatRoomsNetworkManagerDelegate {
    enum NetworkError: Error {
      case parsing(description: String)
      case network(description: String)
    }
    
    func loadUserChatRooms(arrayOfChatIDs: [Int]) -> AnyPublisher<ChatRoomsResponse, Error> {
        let urlString = "http:/localhost:8080/loadchats?id=\(arrayOfChatIDs.map({String($0)}).joined(separator: ","))"
        
        guard let components = URLComponents(string: urlString), let url = components.url else {
            return Fail(error:  NetworkError.network(description: "Error validating the user")).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: ChatRoomsResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
