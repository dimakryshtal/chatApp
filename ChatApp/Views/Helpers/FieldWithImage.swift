//
//  FieldWithImage.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 12.03.2022.
//

import SwiftUI

func rect(lineWidth: CGFloat) -> some View {
    return RoundedRectangle(cornerRadius: 37, style: .continuous)
            .strokeBorder(.white, lineWidth: lineWidth)
            .background(RoundedRectangle(cornerRadius: 37)
            .fill(.white))
            .shadow(radius: 3)
}

struct FieldWithImage: View {
    var imageName: String?
    var fieldName: String
    @Binding var textValue: String
    var body: some View {
        HStack{
            if let imageName = imageName {
                Image(systemName: imageName)
                    .resizable()
                    .foregroundColor(Color.primaryColorBlue)
                    .frame(width: 25, height: 25)
            }
            TextField(fieldName, text: $textValue)
                .foregroundColor(Color.primaryColorBlue)
                .font(.system(size: 18, weight: .medium, design: .default))
                .frame(height: 60)
        }
        .padding(.leading, 25)
        .background(rect(lineWidth: 0))
        
    }
}

struct FieldWithImage_Previews: PreviewProvider {
    static var previews: some View {
        FieldWithImage(imageName: "person", fieldName: "UserName", textValue: .constant("Test"))
    }
}
