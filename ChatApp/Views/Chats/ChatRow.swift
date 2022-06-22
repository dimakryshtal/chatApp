//
//  ChatRow.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI
import Combine

struct ChatRow: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(chatRoom: ChatRoom) {
        viewModel = ViewModel(chatRoom: chatRoom)
        if (viewModel.chat.chatType == "private") {
            viewModel.getChatName()
        }
    }
    
    var body: some View {
        ZStack {
            
            HStack (alignment: .top, spacing: 15) {
                CircleImage(image: Image("kitty"))
                    .frame(width: 70, height: 70, alignment: .center)

                    
                VStack(alignment: .leading, spacing: 5)  {
                    Text(viewModel.chatName ?? "Chat user")
                        .font(.title)
                        .onAppear{
                            if (viewModel.chat.chatType == "private") {
                                viewModel.getChatName()
                            }
                        }
                    Text("Last Message")
                    
                    
                }
                Spacer()
            }
            .padding(10)
           
        }
    }
    
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chatRoom: ChatRoom.defaultChatRoom)
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
