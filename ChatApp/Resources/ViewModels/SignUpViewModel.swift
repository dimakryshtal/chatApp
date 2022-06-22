//
//  RegisterViewModel.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.04.2022.
//

import Foundation
import Combine
import SwiftUI

extension SignUp {
    class RegisterViewModel: ObservableObject {
        @Published var showingAlert: Bool = false
        @Published var authenticator: String = ""
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var firstName: String = ""
        @Published var lastName: String = ""
        
        
        private var subscribers = Set<AnyCancellable>()
        
        func sendNewUser(user: User) {
            UserNetworkManager.shared.createNewUser(requestBody: user)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { response in
                    switch response {
                    case .failure:
                        self.showingAlert = true
                        return
                    case .finished:
                        print("Succeesfully finished!")
                    }
                }, receiveValue: { value in print ("\(value)")
                })
                .store(in: &subscribers)
        }
    }
}
