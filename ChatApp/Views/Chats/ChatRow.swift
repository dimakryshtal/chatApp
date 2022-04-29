//
//  ChatRow.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI

struct ChatRow: View {
    var body: some View {
        ZStack {
            HStack (alignment: .top, spacing: 15) {
                CircleImage(image: Image("kitty"))
                    .frame(width: 70, height: 70, alignment: .center)

                    
                VStack(alignment: .leading, spacing: 5)  {
                    Text("Name Name")
                        .font(.title)
                    Text("Last Message")
                    
                    
                }
                Spacer()
            }
        }
//        .padding([.leading, .trailing], 10)
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow()
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
