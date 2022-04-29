//
//  MessagesNetworkManages.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 25.04.2022.
//

import Foundation
import Combine

protocol MessagesNetworkManagerDelegate {
    func loadMessages(chat_id: Int) -> AnyPublisher<MessagesResponse, Error>
}

final class MessagesNetworkManager {
    static let shared = MessagesNetworkManager()
    
    let decoder = JSONDecoder()
}

extension MessagesNetworkManager:  MessagesNetworkManagerDelegate {
    enum NetworkError: Error {
      case parsing(description: String)
      case network(description: String)
    }
    func loadMessages(chat_id: Int) -> AnyPublisher<MessagesResponse, Error> {
        let urlString = "http://localhost:8080/messagesfrom/\(chat_id)"
        
        guard let components = URLComponents(string: urlString), let url = components.url else {
            return Fail(error: NetworkError.network(description: "Error")).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MessagesResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
