//
//  ContentView.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 11.03.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authenticaion = Authentication()

    var body: some View {
        if (authenticaion.homeWindowIsShown == true) {
            HomeWindow(auth: authenticaion)
        } else {
            MainView()
                .environmentObject(authenticaion)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
