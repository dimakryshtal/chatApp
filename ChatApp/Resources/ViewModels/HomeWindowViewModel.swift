//
//  HomeWindow - ViewModel.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.04.2022.
//

import Foundation
import Combine
import SwiftUI

extension HomeWindow {
    class HomeWindowViewModel: ObservableObject {
        @Published var showBackground = false
        @Published var showingAlert = false
        @Published var authenticator: String = "dima_krshl"
        @Published var password: String = "2508"
        @Published var showSignUp = false
        @Published var showButtons = false
        
        var authentication: Authentication
        
        init(auth: Authentication) {
            authentication = auth
        }
        
        private var subscribers = Set<AnyCancellable>()
        
        func injection(auth: Authentication) {
            self.authentication = auth
            
        }
        
       
        
        func showInterfaceButtons() {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 1).delay(2)) {
                    self.showButtons.toggle()
                }
            }
        }
        
        func successfullLogin() {
            withAnimation {
                showButtons = false
            }
            showBackground = false
        }
        
        func hideHomeWindow() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.authentication.changeHomeWindowStatus()
                }
            }
        }
        
        func logIn() {
            if (authenticator == "") {
                self.successfullLogin()
                UserData.shared.saveData(user: User.defaultUser)
                self.authentication.changeStatus()
                self.hideHomeWindow()
            } else {
                UserNetworkManager.shared.login(requestBody: ["username": authenticator, "password": password])
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { response in
                        print(response)
                        switch response {
                        case .failure:
                            print("\n\n\n\n \(response)")
                            self.showingAlert = true
                            return
                        case .finished:
                            self.successfullLogin()
                            self.authentication.changeStatus()
                            self.hideHomeWindow()
                            return
                            
                        }
                    }, receiveValue: {
                        value in print ("\(value)")
                        UserData.shared.saveData(user: value.user)
                    })
                    .store(in: &subscribers)
            }
        }
    }
}
