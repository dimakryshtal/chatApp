//
//  SecretFieldWithImage.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 12.03.2022.
//

import SwiftUI

struct SecretFieldWithImage: View {
    var fieldName: String
    @Binding var textValue: String
    var body: some View {
        HStack{
            Image(systemName: "lock")
                .frame(width: 15, height: 20)
            TextField(fieldName, text: $textValue)
                .frame(height: 40)
        }
        .padding(.leading, 10)
        .background(rect(lineWidth: 4))
        
    }
}

struct SecretFieldWithImage_Previews: PreviewProvider {
    static var previews: some View {
        SecretFieldWithImage(fieldName: "Password", textValue: .constant("test"))
    }
}
