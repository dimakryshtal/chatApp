//
//  FriendsRow.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 09.05.2022.
//

import SwiftUI

struct FriendsRow: View {
    @EnvironmentObject var friendsData: FriendsData
    @State var isAdded = false
    var showAddButton: Bool = false
    var userItem: User
    
    var body: some View {
        HStack(alignment: .center) {
            CircleImage(image: Image("kitty"))
                .frame(width: 70, height: 70)
                .padding(.leading, 5)
            Text(userItem.username)
                .font(.system(size: 23))
            Spacer()
            if showAddButton {
                Image(systemName: isAdded ? "checkmark.circle" : "plus.circle")
                    .scaleEffect(2)
                    .padding(.trailing, 40)
                    .onTapGesture {
                        isAdded = true
                        friendsData.addItem(item: userItem)
                    }
            }
        }
        .foregroundColor(.chatUserColor)
    }
}

struct FriendsRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendsRow(showAddButton: true, userItem: User.defaultUser)
        .previewLayout(.fixed(width: 400, height: 80))
    }
}
