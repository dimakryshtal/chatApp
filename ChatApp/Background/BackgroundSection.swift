//
//  BackgroundSection.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 20.03.2022.
//

import SwiftUI

func deg2rad(_ number: Double) -> Double {
    return number * .pi / 180
}

struct BackgroundSection: View {
    var shorterSide: CGFloat
    var sectionThickness: CGFloat
    var angle: Double
    var color: Color
    
    
    var body: some View {
        let length = shorterSide / sin(deg2rad(90 - angle))
        Rectangle()
            .fill(color)
            .frame(width: length * 1.2, height: sectionThickness, alignment: .leading)
            .rotationEffect(Angle(degrees: angle))
        
    }
}

struct BackgroundSection_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundSection(shorterSide: 390, sectionThickness: 50, angle: 45, color: Color(0x853EC3, alpha: 0.1))
        
    }
}
