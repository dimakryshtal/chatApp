//
//  Background.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 21.03.2022.
//

import SwiftUI

struct Background: View {
    @Binding var showBackground: Bool
    
    var parallelogramFrameHeight: CGFloat
    var sectionAngle: Double
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    var body: some View {
        let sectionThickness: CGFloat = 70
        let offsetDeltaY = sectionThickness / sin(deg2rad(90.0 - sectionAngle))
        let offsetDeltaX = sectionThickness / cos(deg2rad(90.0 - sectionAngle))
        let positionX = screenWidth * 5 / 4
        
        let numberOfSections =  Int(screenWidth / offsetDeltaX + screenHeight / offsetDeltaY)
        ZStack {
            ForEach((0...numberOfSections), id: \.self) { index in
                BackgroundSection(
                    shorterSide: screenWidth,
                    sectionThickness: sectionThickness,
                    angle: sectionAngle,
                    color: .primaryColorPurple.opacity(Double(index) / Double(numberOfSections))
                )
                
                .position(x: -screenWidth * 3 / 4 + (showBackground ? positionX : 0),
                          y: -160 + (offsetDeltaY * Double(index)) + (showBackground ? screenWidth: 0) - (screenWidth*tan(deg2rad(sectionAngle))))
                
                .animation(.ripple(index: index, backgroundIsShown: showBackground, numberOfSections: numberOfSections).speed(0.8))
            }
        }
        
        .onAppear {
            showBackground = true
        }

        .ignoresSafeArea()
        
    }
}

struct Background_Previews: PreviewProvider {
    
    static var previews: some View {
        Background(showBackground: .constant(true),
                   parallelogramFrameHeight: 390,
                   sectionAngle: 45,
                   screenWidth: 390,
                   screenHeight: 844)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
            .previewDisplayName("iPhone 13")
    }
}
