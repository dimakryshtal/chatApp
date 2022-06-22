//
//  Chat.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI
import SocketIO

struct Chat: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: ChatViewModel
    @Namespace var bottomID
    var userName: String
    
    init(chatRoom: ChatRoom, messages: MessagesData, name: String) {
        viewModel = ChatViewModel(chatRoom: chatRoom, messages: messages)
        userName = name
    }
    
    var body: some View {
        NavigationView{
            
            ZStack(alignment: .bottom) {
                Color.blue.opacity(0.03)
                    .ignoresSafeArea()
                
                VStack{
                    ScrollViewReader {proxy in
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.messages.messages[viewModel.chatData.id] ?? []) { message in
                                    ChatBubble(position: message.user_id == UserData.shared.getUserId() ? .right : .left,
                                               pending: (message.pending == nil) ? false : true, time: message.date ?? "10/10/10 00:00:00") {
                                        Text(message.message)
                                    }
                                }
                                .onAppear {
                                    proxy.scrollTo(viewModel.messages.messages[viewModel.chatData.id]!.last?.id, anchor: .bottom)
                                }
                                .onChange(of: viewModel.messages.messages[viewModel.chatData.id]) { newValue in
                                    proxy.scrollTo(viewModel.messages.messages[viewModel.chatData.id]!.last?.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        FieldWithImage(fieldName: "Message", textValue: $viewModel.newMessageValue)
                            .frame(width: 300, height: 40)
                            .padding(.trailing, 10)
                        Image(systemName: "arrow.up.message")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .scaleEffect(viewModel.sendIsTapped ? 1.3 : 1.0)
                            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: viewModel.sendIsTapped)
                            .onTapGesture {
                                
                                viewModel.sendMessage()

                            }
                        
                        
                    }
                    .frame(width: 390, height: 60)
                    .background(Color.clear.background(.thinMaterial))
                    .ignoresSafeArea()
                }
            }
            .navigationTitle(userName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Hide") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat(chatRoom: ChatRoom.defaultChatRoom, messages: MessagesData(chat_ids: ["00000.0"]), name: "Test User")
    }
}
