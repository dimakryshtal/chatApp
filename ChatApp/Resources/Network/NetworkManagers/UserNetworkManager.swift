//
//  NetworkManager.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 12.03.2022.
//

import Foundation
import Combine

protocol NetworkManagerDelegate {
    func createNewUser(requestBody: User) -> AnyPublisher <CreateUserResponse, Error>
    func login(requestBody: [String: String]) -> AnyPublisher<LoginResponse, Error>
}

final class UserNetworkManager {
    static let shared = UserNetworkManager()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init() {
        encoder.outputFormatting = .prettyPrinted
    }
}

extension UserNetworkManager: NetworkManagerDelegate {
    enum NetworkError: Error {
      case parsing(description: String)
      case network(description: String)
    }
    
    //REGISTER
    func createNewUser(requestBody: User) -> AnyPublisher<CreateUserResponse, Error> {
           let urlString = "http:/localhost:8080/register"
           
           guard let components = URLComponents(string: urlString), let url = components.url else {
               return Fail(error:  NetworkError.network(description: "Error creating user")).eraseToAnyPublisher()
           }
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("application/json", forHTTPHeaderField: "Accept")
           request.httpBody = try? encoder.encode(requestBody)
           
           
            return URLSession.shared.dataTaskPublisher(for: request)
               .map(\.data)
               .decode(type: CreateUserResponse.self, decoder: decoder)
               .eraseToAnyPublisher()
       }
    //LOGIN
    func login(requestBody: [String: String]) -> AnyPublisher<LoginResponse, Error> {
        let urlString = "http:/localhost:8080/login"
        
        guard let components = URLComponents(string: urlString), let url = components.url else {
            return Fail(error:  NetworkError.network(description: "Error validating the user")).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? encoder.encode(requestBody)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
}
