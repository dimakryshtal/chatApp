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
    let pending: Bool
    let time: String
    let content: () -> Content
    
    init (position: BubblePosition, pending: Bool, time: String, @ViewBuilder content: @escaping () -> Content) {
        self.position = position
        self.content = content
        self.pending = pending
        self.time = time
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .trailing, spacing: 0) {
                content()
                HStack(spacing: 0) {
                    Text(String(time.suffix(8).dropLast(3)))
                        .font(.system(size: 10))
                    if(pending) {
                        Image(systemName: "hourglass")
                            .scaleEffect(0.7)
                    } else {
                        Image(systemName: "checkmark.circle")
                            .scaleEffect(0.7)
                    }
                }
            }
            .padding([.top, .bottom], 3)
            .padding([.leading, .trailing], 10)
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
        ChatBubble(position: .right, pending: true, time: "10/10/2010 10:10:10") {
            Text("Thkmjnjnjjjjjn ")
        }
    }
}
