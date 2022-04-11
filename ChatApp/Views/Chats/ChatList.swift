//
//  ChatList.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI

struct ChatList: View {
    var body: some View {
        List {
            ChatRow()
            ChatRow()
            ChatRow()
            ChatRow()
        }
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.all)
        .listStyle(GroupedListStyle())
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
