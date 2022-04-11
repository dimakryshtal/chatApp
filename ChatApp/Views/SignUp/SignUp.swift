//
//  SignUp.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 11.03.2022.
//

import SwiftUI

struct SignUp: View {
    @State private var authenticator: String = "d"
    @State private var email: String = "d@dc.c"
    @State private var password: String = "d"
    @State private var firstName: String = "d"
    @State private var lastName: String = "d"
    
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 15) {
                HStack(alignment: .center, spacing: 10) {
                    FieldWithImage(imageName: nil, fieldName: "First Name", textValue: $firstName)
                    FieldWithImage(imageName: nil, fieldName: "Last Name", textValue: $lastName)
                }
                
                FieldWithImage(imageName: "person", fieldName: "Username", textValue: $authenticator)
                FieldWithImage(imageName: "envelope", fieldName: "E-mail", textValue: $email)
                SecretFieldWithImage(fieldName: "Password", textValue: $password)
                
                Button("Sign Up") {
                    let user = User(firstName: firstName, lastName: lastName, username: authenticator, email: email, password: password)
                    NetworkManager.shared.createNewUser(requestBody: user)
                    
                }
                .buttonStyle(CustomButtonStyle())
                
            }
            .padding()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
