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
    @EnvironmentObject var homeWindowViewModel: HomeWindowViewModel
    
    var drag: some Gesture {
        var previousGesture:CGFloat = 0.0
        
        return DragGesture()
                .onChanged { value in
                    let sizeDelta = value.translation.height - previousGesture
                    let newSize = pictureSize + sizeDelta
                    
                    if sizeDelta > 0 {
                        pictureSize = newSize < 300 ? newSize : 300
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
                
                VStack {
                    Text("Meow Meow")
                        .font(.system(size: 25, weight: .medium, design: .default))
                        .foregroundColor(Color(0xF4ECFA))
                        .padding(.bottom, 30)
                    
                    CircleImage(image: Image("kitty"))
                        .frame(width: pictureSize, height: pictureSize, alignment: .center)

//                            .stroke(Color.primaryColorPurple, lineWidth: 4))
                }
                .background(Circle()
                    .fill(LinearGradient(colors: [.primaryColorPurple, .primaryColorPurple.opacity(0.1)], startPoint: .center, endPoint: .bottomTrailing))
                    .frame(width: UIScreen.screenWidth * 1.6, height: UIScreen.screenWidth * 1.6)
                    .offset(y:  -UIScreen.screenWidth * 0.7)
                    .ignoresSafeArea())
            
            
            
            
            List {
                ZStack{
                    VStack {
                        ForEach(1..<20) { index in
                            Text("\(index)")
                        }
                        Button ("Log Out") {
                            Socket.shared.disconnect()
                            withAnimation {
                                UserDefaults.standard.set(nil, forKey: "Current user")
                                homeWindowViewModel.authentication.changeStatus()
                                homeWindowViewModel.homeWindowIsShown = true
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
        Profile()
            .environmentObject(HomeWindowViewModel(auth: Authentication()))
            .previewInterfaceOrientation(.portrait)
    }
}
