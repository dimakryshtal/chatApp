//
//  AnimationExtensions.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 22.03.2022.
//

import SwiftUI

extension Animation {
    static func ripple(index: Int, backgroundIsShown: Bool, numberOfSections: Int) -> Animation {
        Animation.spring(dampingFraction: 1)
            .speed(2)
            .delay(0.1 * Double(backgroundIsShown ? index : (numberOfSections - index)))
    }
}
