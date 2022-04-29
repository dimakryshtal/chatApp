//
//  HomeWindow - ViewModel.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.04.2022.
//

import Foundation
import Combine
import SwiftUI

class HomeWindowViewModel: ObservableObject {
    @Published var showBackground = false
    @Published var showingAlert = false
    
    @Published var authenticator: String = "dima_krshl"
    @Published var password: String = "2508"
    
    @Published var showLogIn = false
    @Published var showSignUp = false
    
    @Published var showButtons = false
    @Published var homeWindowIsShown = true
    
    
    var authentication: Authentication
    
    init(auth: Authentication) {
        authentication = auth
    }
    
    private var subscribers = Set<AnyCancellable>()

    func injection(auth: Authentication) {
        self.authentication = auth

    }
    
    func signUp() {
        showBackground = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showSignUp.toggle()
        }
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
                self.homeWindowIsShown = false
            }
        }
    }
    
    func logIn() {
        if (authenticator == "") {
            self.successfullLogin()
            self.authentication.changeStatus()
            self.hideHomeWindow()
        } else {
        UserNetworkManager.shared.login(requestBody: ["username": authenticator, "password": password])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure:
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
                UserDefaults.standard.set(value.user.user_id, forKey: "User_id")
                UserDefaults.standard.set(value.user.username, forKey: "Username")
                UserDefaults.standard.set(value.user.firstName, forKey: "FirstName")
                UserDefaults.standard.set(value.user.lastName, forKey: "LastName")
                UserDefaults.standard.set(value.user.userChats, forKey: "UserChats")
            })
            .store(in: &subscribers)
        }
    }
    
}
