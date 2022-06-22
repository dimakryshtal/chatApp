//
//  SecretFieldWithImage.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 12.03.2022.
//

import SwiftUI

struct SecretFieldWithImage: View {
    var fieldName: String
    var lineWidth: CGFloat = 0
    @Binding var textValue: String
    var body: some View {
        HStack{
            Image(systemName: "lock")
                .foregroundColor(.gray)
                .aspectRatio(contentMode: .fit)
            
            SecureField(fieldName, text: $textValue)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.leading, 15)
        .background(rect(lineWidth: lineWidth))
        
    }
}

struct SecretFieldWithImage_Previews: PreviewProvider {
    static var previews: some View {
        SecretFieldWithImage(fieldName: "Password", textValue: .constant("test"))
    }
}
