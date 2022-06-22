//
//  CircleImage.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 18.03.2022.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
//            .shadow(color: .primaryColorPurple, radius: 2)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("kitty"))
            .frame(width: 200, height: 200, alignment: .center)
    }
}
