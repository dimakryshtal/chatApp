//
//  FindFriendsViewModel.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 10.05.2022.
//

import Foundation
import Combine

extension FindFriends {
    class ViewModel: ObservableObject {
        @Published var foundUsers: [User] = []
        @Published var searchText = "" {
            didSet {
                searchResults()
            }
        }
        private var subscribers = Set<AnyCancellable>()
        
        
        func searchResults(){
            if searchText.count >= 3 {
                UserNetworkManager.shared.getUsers(query: "?searchval=\(searchText)")
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { response in
                        print(response)
                    }, receiveValue: {value in print ("\(value)")
                        print(value)
                        self.foundUsers = value
                        print(value)
                    })
                    .store(in: &subscribers)
            } else {
                self.foundUsers = []
            }
        }
    }
}
