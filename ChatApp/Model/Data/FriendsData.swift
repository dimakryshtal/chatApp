//
//  FriendsData.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 13.05.2022.
//

import Foundation
import Combine

final class FriendsData: ObservableObject {
    var subscribers = Set<AnyCancellable>()
    @Published var friends: [User] = []
    
    init(friendsIds: [String]) {
        if friendsIds.count != 0 {
            UserNetworkManager.shared.getUsers(query: "?searchids=\(friendsIds.map{ String($0) }.joined(separator: ", "))")
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { response in
                    print(response)
                }, receiveValue: { value in
                    print("\n\n\n\(value)")
                    self.friends = value
                })
                .store(in: &subscribers)
        }
    }
    
    func addItem (item: User) {
        print("\n\n\n\n \(item)")
        self.friends.append(item)
        UserNetworkManager.shared.updateCurrentUser(username: UserData.shared.getUserName(),
                                                    requestBody: ["$push": ["userFriends" : item.id]])
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { response in
            switch response {
            case .failure:
                return
            case .finished:
                print("Succeesfully finished!")
            }
        }, receiveValue: { value in print ("\(value)")
        })
        .store(in: &subscribers)
    }
    
}
