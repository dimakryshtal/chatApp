//
//  Login.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 11.03.2022.
//

import SwiftUI

struct Login: View {
    @State private var authenticator: String = ""
    @Binding var isLogged: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            FieldWithImage(imageName: "person", fieldName: "Username", textValue: $authenticator)
            
            HStack{
                Image(systemName: "person")
                SecureField("Password", text: $authenticator)
                    .frame(height: 40)
            }
            .padding(.leading, 10)
            .background(rect(lineWidth: 7))
        
            Button("Log In") {
                withAnimation(.default){
                    isLogged = true
                }
            }
            .buttonStyle(CustomButtonStyle())
            
            NavigationLink(destination: SignUp()) {
                Text("Sign Up")
            }
            .buttonStyle(CustomButtonStyle())
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(isLogged: .constant(false))
    }
}
