//
//  Extensions.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 12.03.2022.
//

import Foundation
import SwiftUI

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
    
    static let primaryColorBlue = Color(0x9EBCE8)
    static let primaryColorPurple = Color(0x853EC3)
    static let secondaryColor = Color(0xEFF3FF)
    static let gradientColor1 = Color(0x743175)
    static let gradientColor2 = Color(0xB1529E)
    static let chatUserColor = Color(0x9567C9)
}

