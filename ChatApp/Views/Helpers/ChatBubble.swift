//
//  ChatBubble.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 13.04.2022.
//

import SwiftUI

enum BubblePosition {
    case left
    case right
}

struct ChatBubble<Content: View> : View {
    let position: BubblePosition
    let content: () -> Content
    
    init (position: BubblePosition, @ViewBuilder content: @escaping () -> Content) {
        self.position = position
        self.content = content
    }
    
    var body: some View {
        HStack {
             content()
                .padding()
                .background(position == .left ? .white : .chatUserColor)
                .foregroundColor(position == .left ? Color(0x6C6C6C) : .white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(
                    Image(systemName: "arrowtriangle.\(position).fill")
                        .foregroundColor(position == .left ? .white : .chatUserColor)
                        .rotationEffect(Angle(degrees: position == .left ? -45 : 45))
                        .offset(x: position == .left ? -5 : 5)
                        
                    , alignment: position == .left ? .bottomLeading : .bottomTrailing)
                .frame(maxWidth: UIScreen.screenWidth * 8 / 10, alignment: position == .left ? .leading : .trailing)
        }
        .frame(maxWidth: UIScreen.screenWidth, maxHeight:  .infinity,
               alignment: position == .left ? .leading : .trailing)
        .padding(position == .left ? .leading : .trailing, 10)
    }
    
}


struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(position: .left
        ) {
            Text("Test")
        }
    }
}
