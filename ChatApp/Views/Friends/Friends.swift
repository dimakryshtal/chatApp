//
//  Friends.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 09.05.2022.
//

import SwiftUI

struct Friends: View {
    @EnvironmentObject var friendsData: FriendsData
    @State private var showingSheet = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.03)
                    .ignoresSafeArea()
                Group {
                    if friendsData.friends.count != 0 {
                        List {
                            ForEach(friendsData.friends, id: \.self) { item in
                                NavigationLink {
                                    FriendDetails(user: item)
                                } label: {
                                    FriendsRow(userItem: item)
                                }
                            }
                        }
                    } else {
                        Text("No friends")
                    }
                    
                }
                .navigationTitle("Friends")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Add friends") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        FindFriends()
                    }
                }
            }
        }.accentColor(Color.primaryColorBlue)
    }
}

struct Friends_Previews: PreviewProvider {
    static var previews: some View {
        Friends()
            .environmentObject(FriendsData(friendsIds: ["111111"]))
    }
}
