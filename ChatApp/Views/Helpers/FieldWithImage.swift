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
            
}

struct FieldWithImage: View {
    var imageName: String?
    var fieldName: String
    @Binding var textValue: String
    var body: some View {
        HStack{
            if let imageName = imageName {
                Image(systemName: imageName)
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
                    
            }
            TextField(fieldName, text: $textValue)
                .foregroundColor(.gray)
                .font(.system(size: 18, weight: .medium, design: .default))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.leading, 15)
        .background(rect(lineWidth: 0))
        
    }
}

struct FieldWithImage_Previews: PreviewProvider {
    static var previews: some View {
        FieldWithImage(imageName: "lock", fieldName: "UserName", textValue: .constant("Test"))
            .previewLayout(.fixed(width: 390, height: 50))
    }
}
