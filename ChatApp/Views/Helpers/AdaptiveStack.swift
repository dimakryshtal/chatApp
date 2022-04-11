//
//  AdaptiveStack.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 27.03.2022.
//

import SwiftUI

struct AdaptiveStack<Content: View> : View {
    
    @Binding var fullPicture: Bool
    
    var horizontalAlignment: HorizontalAlignment
    var verticalAlignment: VerticalAlignment
    var spacing: CGFloat?
    var content: () -> Content
    
    init(horizontalAlignment: HorizontalAlignment = .center,
         verticalAlignment: VerticalAlignment = .center,
         spacing: CGFloat? = nil,
         fullPicture: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self._fullPicture = fullPicture
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        Group {
            if fullPicture {
                VStack(alignment: horizontalAlignment, spacing: spacing, content: content)
            } else {
                HStack(alignment: verticalAlignment, spacing: spacing, content: content)
                    .padding()
            }
        }
    }
}
