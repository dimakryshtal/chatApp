//
//  Authentication.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 15.03.2022.
//

import Foundation

class Authentication: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
            print(isLoggedIn)
        }
    }
    
    init() {
//        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        isLoggedIn = false
    }
    
    func changeStatus() {
        isLoggedIn.toggle()
    }
}
