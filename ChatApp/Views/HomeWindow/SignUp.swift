//
//  SignUp.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 11.03.2022.
//

import SwiftUI
import Combine

struct SignUp: View {
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 15) {
                HStack(alignment: .center, spacing: 10) {
                    FieldWithImage(imageName: nil, fieldName: "First Name", textValue: $viewModel.firstName)
                    FieldWithImage(imageName: nil, fieldName: "Last Name", textValue: $viewModel.lastName)
                }
                
                FieldWithImage(imageName: "person", fieldName: "Username", textValue: $viewModel.authenticator)
                FieldWithImage(imageName: "envelope", fieldName: "E-mail", textValue: $viewModel.email)
                SecretFieldWithImage(fieldName: "Password", textValue: $viewModel.password)
                
                Button("Sign Up") {
                    let user = User(firstName: viewModel.firstName,
                                    lastName: viewModel.lastName,
                                    username: viewModel.authenticator,
                                    email: viewModel.email,
                                    password: viewModel.password)
                    viewModel.sendNewUser(user: user)
                    
                }
                .buttonStyle(CustomButtonStyle())
                .alert("User already exists.", isPresented: $viewModel.showingAlert) {
                    Button("OK", role: .cancel) { }
                }
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
