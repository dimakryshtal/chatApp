//
//  FindFriends.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 09.05.2022.
//

import SwiftUI
import Combine

struct FindFriends: View {
    @StateObject private var viewModel: ViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(viewModel.foundUsers, id: \.self) { item in
                    FriendsRow(showAddButton: true, userItem: item)
                }
            }
            .navigationTitle("Find friends")
            .searchable(text: $viewModel.searchText)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FindFriends_Previews: PreviewProvider {
    static var previews: some View {
        FindFriends()
    }
}
