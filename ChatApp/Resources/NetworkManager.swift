//
//  NetworkManager.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 12.03.2022.
//

import Foundation
import Combine

final class NetworkManager {
    static let shared = NetworkManager()

    
    var cancellables = Set<AnyCancellable>()
}

extension NetworkManager {
    
    func createNewUser(requestBody: User) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let urlString = "http:/localhost:8080/register"
        
        guard let components = URLComponents(string: urlString), let url = components.url else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? encoder.encode(requestBody)
        
        
        URLSession.shared.dataTaskPublisher(for: request)
            .print()
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .sink(receiveCompletion: { print ("Received completion: \($0).") },
                  receiveValue: { value in print ("\(value)")})
            .store(in: &cancellables)

    }
}

