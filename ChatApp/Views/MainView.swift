//
//  MainView.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelection:Tab = .chats
    @Binding var isLoggedIn: Bool
    
    enum Tab {
        case chats
        case profile
    }
    
    var body: some View {
        TabView{
            ChatList()
                .tabItem {
                       Label("Chats", systemImage: "mail")
                }
                .tag(Tab.chats)
            
            Profile(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(isLoggedIn: .constant(true))
    }
}
