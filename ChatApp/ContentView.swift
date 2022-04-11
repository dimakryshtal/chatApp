//
//  ContentView.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 11.03.2022.
//

import SwiftUI

struct ContentView: View {
    @Binding var isLoggedIn:Bool
    @ObservedObject var auth: Authentication

    var body: some View {
        if (!isLoggedIn) {
            HomeWindow(auth: auth, isLoggedIn: $isLoggedIn)
                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
        } else {
            MainView(isLoggedIn: $isLoggedIn)
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isLoggedIn:.constant(false),  auth: Authentication())
    }
}
