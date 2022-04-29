//
//  ContentView.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 11.03.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeWindowViewModel = HomeWindowViewModel(auth: Authentication())
    
    

    var body: some View {
        if (homeWindowViewModel.homeWindowIsShown == true) {
            HomeWindow(viewModel: homeWindowViewModel)
        } else {
            MainView()
                .environmentObject(homeWindowViewModel)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView(isLoggedIn:.constant(false),  auth: Authentication())
        
        ContentView()
            
    }
}
