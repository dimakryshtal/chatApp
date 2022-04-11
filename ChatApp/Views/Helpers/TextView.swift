//
//  TextView.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 04.04.2022.
//

import SwiftUI

struct TextView: View {
    var text: String
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        Text(text)
            .padding()
            .frame(maxWidth: width, maxHeight: height, alignment: .leading)
            .background(rect(lineWidth: 0))
            .font(.system(size: 20, weight: .medium, design: .default))
            .foregroundColor(Color.primaryColorBlue)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: "Test", width: .infinity, height: 50)
    }
}
