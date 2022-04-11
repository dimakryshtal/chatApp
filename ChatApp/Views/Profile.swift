//
//  Profile.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 17.03.2022.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    
    typealias Value = CGFloat
    static var defaultValue: Value = Value.zero
   
    static func reduce(value: inout Value, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct Profile: View {
    @State private var pictureSize: CGFloat = 100
    @State private var isDragging: Bool = false
    @Binding var isLoggedIn: Bool
    
    var drag: some Gesture {
        var previousGesture:CGFloat = 0.0
        
        return DragGesture()
                .onChanged { value in
                    let sizeDelta = value.translation.height - previousGesture
                    let newSize = pictureSize + sizeDelta
                    
                    if sizeDelta > 0 {
                        pictureSize = newSize < 370 ? newSize : 370
                    } else if (sizeDelta < 0) {
                        pictureSize = newSize > 100 ? newSize : 100
                    }
                    
                    previousGesture = value.translation.height
                    
                }
                .onEnded { _ in
                    isDragging = false
                    
                }
    }
    
    var body: some View {
        
        VStack {
            AdaptiveStack (fullPicture: .constant(true)) {
                Image("kitty")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color(0x743175), lineWidth: 4))
                    .frame(width: pictureSize, height: pictureSize, alignment: .center)

                TextView(text: "Meow Meow", width: .infinity, height: 50)
                    .padding([.leading, .trailing, .bottom], 10)
            }
            
            .background(RoundedRectangle(cornerRadius: 40, style: .continuous)
                .fill(LinearGradient(colors: [Color.gradientColor1, Color.gradientColor2], startPoint: .bottom, endPoint: .top))
                .ignoresSafeArea()
            )
            
            
            List {
                ZStack{
                    VStack {
                        ForEach(1..<20) { index in
                            Text("\(index)")
                        }
                        Button ("Log Out") {
                            withAnimation {
                                isLoggedIn = false
                            }
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                    GeometryReader { proxy in
                        Color.clear.preference(key: ViewOffsetKey.self,
                                               value: -proxy.frame(in: .named("scroll")).origin.y)
                    }
                }
            }
            .listStyle(.plain)
            .onAppear(perform: {UITableView.appearance().isScrollEnabled = false})
            .gesture(drag)
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ViewOffsetKey.self) { value in
                if (value >= 0.0) {
                    isDragging = true
                }
            }

        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(isLoggedIn: .constant(true))
            .previewInterfaceOrientation(.portrait)
    }
}
