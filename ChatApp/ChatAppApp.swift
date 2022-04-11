//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 11.03.2022.
//

import SwiftUI

@main
struct ChatAppApp: App {
    @StateObject private var authentication = Authentication()
    
    var body: some Scene {
        WindowGroup {
            ContentView(isLoggedIn: $authentication.isLoggedIn, auth: authentication)
        }
    }
}
