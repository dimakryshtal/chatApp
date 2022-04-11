//
//  CustomTextFields.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 11.03.2022.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 220, height: 50)
            .background(LinearGradient(colors: [Color.gradientColor1, Color.gradientColor2], startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .medium, design: .default))
            .clipShape(Rectangle())
            .cornerRadius(30)
    }
}
